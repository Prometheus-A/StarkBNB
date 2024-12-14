#[starknet::component]
pub mod TransactionHandlerComponent {
    use HostHandlerComponent::HostInternalTrait;
    use starknet::{ContractAddress, get_caller_address, get_contract_address, get_block_timestamp};
    use starknet::storage::{
        Map, StoragePathEntry, Vec, StoragePointerReadAccess, VecTrait, MutableVecTrait,
        StoragePointerWriteAccess
    };
    use openzeppelin_token::erc20::interface::IERC20;
    use openzeppelin_token::erc20::interface::{IERC20Dispatcher, IERC20DispatcherTrait};
    use starkbnb::constants::resolvers::{get_broker, get_holders, get_strk_token_address, generate_id};
    use starkbnb::components::host_service::{HostHandlerComponent, HostHandlerComponent::HostInternalImpl};
    use starkbnb::interfaces::transactions::ITransactionHandler;
    use starkbnb::structs::transactions::{BookedServiceEvent, Booking, Fund};
    use starkbnb::structs::host::Service;

    // broker -- to be deleted in the future
    // holders -- the devs/stakeholders -- to be enhanced in the future
    // the funding is for the sole purpose of whitelisting and blacklisting.
    #[storage]
    pub struct Storage {
        broker: ContractAddress,
        holders: Vec::<ContractAddress>,
        funding: Map::<felt252, Fund>,
        total_balance: u256
    }

//     #[derive(Drop, starknet::Event)]
// pub struct BookedServiceEvent {
//     pub host_address: ContractAddress,
//     pub guest_address: ContractAddress,
//     pub service_id: felt252,
//     pub timestamp: u64
// }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        BookedServiceEvent: BookedServiceEvent
    }

    #[embeddable_as(TransactionHandlerImpl)]
    pub impl TransactionHandler<
        TContractState, +HasComponent<TContractState>, +Drop<TContractState>,
        impl Host: HostHandlerComponent::HasComponent<TContractState>
    > of ITransactionHandler<ComponentState<TContractState>> {
        // fn open_service(ref self: ComponentState<TContractState>, service_id: felt252, ) {
    //     let caller = get_caller_address();
    //     let service: Service = self._check_id(service_id);
    //     assert!(caller == service.owner, "Error: Caller is not Owner");
    //     let transaction_comp = get_dep_component!(@self, Transaction);
    //     transaction_comp.process
    // }

        fn open_service(ref self: ComponentState<TContractState>, service_id: felt252) {
            let caller = get_caller_address();
            let mut hostc = get_dep_component_mut!(ref self, Host);
            let mut service: Service = hostc._check_id(service_id);
            assert!(caller == service.owner, "Err: Caller is Unauthorized.");
            let (mut is_open, _) = service.data.is_open;
            assert!(!is_open, "Err: Service is already open");
            let stake: u256 = _get_stake(service.data.cost);
            let balance = self.strk_dispatcher().balance_of(caller);
            assert!(balance > stake, "Error: Insufficient funds.");
            let approved: bool = self.strk_dispatcher().approve(get_contract_address(), stake);
            let transferred: bool = self.strk_dispatcher().transfer(get_contract_address(), stake);
            assert!(approved && transferred, "Err: Transaction failed.");
            // store these variables to keep track of funds.
            // set is_open to true
        }

        fn book_service(ref self: ComponentState<TContractState>, service_id: felt252) -> felt252 {
            // To book a service, you put in the booking data
            // add a dispute variable. 
            // Close the service till further notice.
            // self.emit(BookedServiceEvent {})

            let mut hostc = get_dep_component_mut!(ref self, Host);
            let mut service: Service = hostc._check_id(service_id);
            let (mut is_open, _) = service.data.is_open;
            assert!(is_open, "Err: Service is closed.");
            let owner: ContractAddress = service.owner;
            let guest: ContractAddress = get_caller_address();

            // set service.data.is_open to false, if successful
            // make sure you withdraw from the caller and keep track of amount.

            0
        }

        fn checkout(ref self: ComponentState<TContractState>, service_id: felt252) {

        }


    }

    #[generate_trait]
    pub impl TransactionInternalImpl<
        TContractState, +HasComponent<TContractState>,
    > of TransactionInternalTrait<TContractState> {

        // For now, we are going to use only strk
        fn strk_dispatcher(self: @ComponentState<TContractState>) -> IERC20Dispatcher {
            IERC20Dispatcher {
               contract_address: get_strk_token_address()
            }
        }

        fn _init(ref self: ComponentState<TContractState>) {
            let holders: Array<ContractAddress> = get_holders();

            // refactor. Consider deleting this broker.
            self.broker.write(get_broker());
            for holder in holders {
                self.holders.append().write(holder);
            };
        }
        // Create a reusable internal function that handles the funding
    }

    fn _get_stake(cost: u256) -> u256 {
        (1 / 3) * cost
    }

    

    // fn book_service(ref self: ComponentState<TContractState>, service_id: felt252) {
    //     let guest: ContractAddress = get_caller_address();
    // assert that the service is open
    // when booked, set the service to closed.

    //     self.service_log.entry(service_id).append().write(guest);
    // }

}