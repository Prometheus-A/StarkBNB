#[starknet::component]
pub mod HostHandlerComponent {
    use starknet::{ContractAddress, get_caller_address};
    use starknet::storage::{
        Map, StoragePathEntry, Vec, StoragePointerReadAccess, VecTrait, MutableVecTrait,
        StoragePointerWriteAccess
    };
    use starkbnb::structs::host::{
        Service, BookedServiceEvent, UploadedServiceEvent, ServiceResolve, OwnershipTransferredEvent
    };
    use starkbnb::interfaces::host::IHostHandler;
    use starkbnb::constants::host_constants::{EMPTY_SERVICE_DATA, SALT};
    use core::poseidon::PoseidonTrait;
    use core::hash::{HashStateTrait, HashStateExTrait};

    use core::num::traits::Zero;


    // This stores the list of addresses hosted on the platform. This is read from to validate a
    // host There is a bool value mapped to each address check if an address is blacklisted. The
    // component checks this storage before accepting a hosts wallet and information.
    //
    // service_log a Map that maps a service id to a list of Guests contract addresses
    // id_list -- Maps the id of a service, and sets the value to true. Used to test of a service
    // with That particular key exists (id_exists, Service)
    #[storage]
    pub struct Storage {
        pub hosts: Map::<ContractAddress, Vec<Service>>,
        pub address_list: Map::<ContractAddress, bool>,
        pub service_log: Map::<felt252, Vec<ContractAddress>>,
        pub id_list: Map::<felt252, (bool, Service)>,
        pub services: Vec::<felt252>,
        pub services_count: u64
    }

    // TODO: Emit an event each time a house is booked...
    // TODO: Consider moving the BookedServiceEvent to the Guest's side

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        BookedServiceEvent: BookedServiceEvent,
        OwnershipTransferredEvent: OwnershipTransferredEvent,
        UploadedServiceEvent: UploadedServiceEvent
    }

    #[embeddable_as(HostHandlerImpl)]
    impl HostHandler<
        TContractState, +HasComponent<TContractState>
    > of IHostHandler<ComponentState<TContractState>> {
        fn upload_service(
            ref self: ComponentState<TContractState>, mut name: felt252
        ) -> (bool, felt252) {
            let mut host: ContractAddress = get_caller_address();
            let is_blacklisted: bool = self.address_list.entry(host).read();
            assert!(is_blacklisted == false, "Error: Host Address is blacklisted");
            self._upload_service(ref host, ref name)
        }

        fn update_service(
            ref self: ComponentState<TContractState>, service_id: felt252, cost: u256
        ) {
            let mut service: Service = self._check_id(service_id);
            self._assert_owner(service.owner);
            self._update_service(ref service, cost);
            self.id_list.entry(service_id).write((true, service));
        }

        fn is_eligible(ref self: ComponentState<TContractState>, service_id: felt252) -> bool {
            // Might be implemented in the future. For now, so far the service exists, return true.
            let _ = self._check_id(service_id);
            true
        }

        fn is_open(ref self: ComponentState<TContractState>, service_id: felt252) -> (bool, u64) {
            let service: Service = self._check_id(service_id);
            service.data.is_open
        }

        fn transfer_ownership(
            ref self: ComponentState<TContractState>, new_host: ContractAddress, service_id: felt252
        ) {
            let mut service: Service = self._check_id(service_id);
            self._assert_owner(service.owner);
            self._transfer_ownership(new_host, service);
        }

        fn delete_service(ref self: ComponentState<TContractState>, service_id: felt252) -> bool {
            let caller_address: ContractAddress = get_caller_address();
            let services_count: u64 = self.services_count.read();
            assert!(services_count != 0, "Error: Bad Request. There are no services currently.");
            let service: Service = self._check_id(service_id);
            let default_address: ContractAddress = 0_felt252.try_into().unwrap();
            let mut empty_service: Service = Service {
                owner: default_address, id: 0, data: EMPTY_SERVICE_DATA
            };

            self._save(service.id, ref empty_service, caller_address);
            self.id_list.entry(service_id).write((false, service));
            self.services_count.write(services_count - 1);
            true
        }

        fn vote(
            ref self: ComponentState<TContractState>,
            service_id: felt252,
            guest: ContractAddress,
            vote_variable: u8,
            direction: bool
        ) {
            // The vote can be any variable/implementation of variable assignment done by the dev in
            // charge of the guest.
            // It should always be true if checked from the front end.
            assert!(vote_variable <= 1, "Error: Illegal vote");
        }

        fn write_log(
            ref self: ComponentState<TContractState>, service_id: felt252, guest: ContractAddress
        ) {
            self.service_log.entry(service_id).append().write(guest);
        }

        fn get_open_services(self: @ComponentState<TContractState>, page: u8) -> Array<Service> {
            self._get_services(page, true)
        }

        fn get_all_services(self: @ComponentState<TContractState>, page: u8) -> Array<Service> {
            self._get_services(page, false)
        }

        fn get_services_by_host(
            self: @ComponentState<TContractState>, host: ContractAddress
        ) -> Array<Service> {
            let mut services: Array<Service> = array![];
            let hosts = self.hosts.entry(host);
            for i in 0
                ..hosts
                    .len() {
                        let service: Service = hosts.at(i).read();
                        if service.owner == host {
                            services.append(service);
                        }
                    };

            services
        }

        fn get_service_by_ids(
            ref self: ComponentState<TContractState>, service_ids: Array<felt252>
        ) -> Array<Service> {
            let mut services: Array<Service> = array![];

            for service_id in service_ids {
                let (exists, service) = self.id_list.entry(service_id).read();
                if exists {
                    services.append(service);
                }
            };

            services
        }
    }

    // When testing, test this trait.
    #[generate_trait]
    pub impl HostInternalImpl<
        TContractState, +HasComponent<TContractState>
    > of HostInternalTrait<TContractState> {
        fn _initialize(ref self: ComponentState<TContractState>) {
            self.services_count.write(0);
            // TODO: This function must be called from the starkbnb sc
        }

        /// Should return a valid service_id
        /// When testing, test the <service>.data.name if it corresponds to what was used to
        /// intialize the service
        fn _upload_service(
            ref self: ComponentState<TContractState>, ref host: ContractAddress, ref name: felt252
        ) -> (bool, felt252) {
            let mut services_count: u64 = self.services_count.read();
            let service_id: felt252 = self._generate_id(ref name);

            // Check if this id already exists
            let (id_exists, _) = self.id_list.entry(service_id).read();
            assert!(id_exists == false, "Error: Id Conflict. This id already exists.");
            let mut service: Service = Service {
                owner: host, id: service_id, data: EMPTY_SERVICE_DATA
            };
            service.data.name = name;

            self._set_eligible(ref service);
            self.hosts.entry(host).append().write(service);
            self.services_count.write(services_count + 1);
            self.address_list.entry(host).write(false);

            self.id_list.entry(service_id).write((true, service)); // The id now exists
            self.services.append().write(service_id);
            self.emit(UploadedServiceEvent { id: service_id, host_address: host });

            (true, service_id)
        }

        fn _generate_id(ref self: ComponentState<TContractState>, ref name: felt252) -> felt252 {
            let service_resolve: ServiceResolve = ServiceResolve { name, salt: SALT };
            let service_id: felt252 = PoseidonTrait::new().update_with(service_resolve).finalize();
            service_id
        }

        fn _assert_owner(self: @ComponentState<TContractState>, host: ContractAddress) {
            let caller: ContractAddress = get_caller_address();
            assert(!caller.is_zero(), 'Error: Zero Address caller');
            assert(caller == host, 'Error: Not owner');
        }

        fn _update_service(
            ref self: ComponentState<TContractState>, ref service: Service, cost: u256
        ) {
            service.data.cost = cost;
            self._save(service.id, ref service, get_caller_address());
        }

        fn _save(
            ref self: ComponentState<TContractState>,
            service_id: felt252,
            ref service: Service,
            address: ContractAddress
        ) {
            let mut index: u64 = 0;

            //          TEST. There's no test for is_none, but this method shouldn't panic.
            loop {
                let vec = self.hosts.entry(address).get(index);
                let service_check: Service = vec.unwrap().read();
                if service_id == service_check.id {
                    vec.unwrap().write(service);
                    break;
                }
                index += 1;
            };
            self.id_list.entry(service.id).write((true, service));
        }

        /// You might need to set a greater security in the future. Till then, it's all based on the
        /// user and his wallet's security.
        fn _transfer_ownership(
            ref self: ComponentState<TContractState>,
            new_host: ContractAddress,
            mut service: Service
        ) {
            assert!(
                service.owner != new_host,
                "Error: This service has alreaady been assigned to this host."
            );
            let old_host: ContractAddress = get_caller_address();
            service.owner = new_host;

            self.hosts.entry(new_host).append().write(service);
            self._save(service.id, ref service, old_host);
            self.id_list.entry(service.id).write((true, service));

            self
                .emit(
                    OwnershipTransferredEvent {
                        service_id: service.id,
                        old_host,
                        new_host,
                        timestamp: starknet::get_block_timestamp()
                    }
                );
        }

        fn _check_id(ref self: ComponentState<TContractState>, service_id: felt252) -> Service {
            let (id_exists, service) = self.id_list.entry(service_id).read();
            assert!(id_exists, "Error: The provided id does not exist!");
            service
        }

        fn _get_services(
            self: @ComponentState<TContractState>, page: u8, open: bool
        ) -> Array<Service> {
            let mut services: Array<Service> = array![];

            let mut size: u16 = if self.services.len() > 20 {
                20_u16
            } else {
                self.services.len().try_into().unwrap()
            };

            let mut start = (size * page.into());
            let mut end = start + size;
            let mut i: u64 = 0_u64;

            while start < end && i < self.services.len() {
                let service_id: felt252 = self.services.at(i).read();
                let (exists, service) = self.id_list.entry(service_id).read();
                if exists {
                    if open {
                        let (is_open, _) = service.data.is_open;
                        if is_open == true {
                            services.append(service);
                            start += 1;
                        }
                    } else {
                        services.append(service);
                        start += 1;
                    }
                }
                i += 1;
            };

            services
        }

        fn _set_eligible(ref self: ComponentState<TContractState>, ref service: Service) {
            // here the id of the service is taken, might not be necessary though.
            // Check poll results
            // set eligible value to true
            // set up the remaining
            // Emit an UploadedServiceEvent if true
            // But for now, we just set the eligiblity to true. Should not panic.
            // Remove the '_' then.
            service.data.is_eligible = true;
        }
    }
}
/// CHECK AGAIN IF YOU NEED TO STORE THE BLOCK TIME STAMP OF A BOOKED HOUSE EVENT. YESSS. AND TELL
/// THE DEV HANDLING IT TO ADD IT BOTH TO BE STORED
///
/// NOTES:
/// // Check if address has any service marked ineligible. If yes, The host must delete the service
/// before
// applying again. These restrictions might be implemented in the future.
// return bool and service_id
// let host_ref = @host;
// For now, all uploaded services will be eligible :)
///
/// When a guest books a service, the service should be logged into the storage.
/// mmmlll


