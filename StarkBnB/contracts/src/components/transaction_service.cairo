#[starknet::component]
pub mod TransactionHandlerComponent {
    use starknet::ContractAddress;
    use starknet::storage::{
        Map, StoragePathEntry, Vec, StoragePointerReadAccess, VecTrait, MutableVecTrait,
        StoragePointerWriteAccess
    };
    use openzeppelin_token::erc20::interface::IERC20;
    use openzeppelin_token::erc20::interface::{IERC20Dispatcher, IERC20DispatcherTrait};
    use starkbnb::constants::resolvers::{get_broker, get_holders, get_strk_token_address};
    use starkbnb::components::host_service::{HostHandlerComponent, HostHandlerComponent::HostInternalImpl};
    use starkbnb::interfaces::transactions::ITransactionHandler;
    use starkbnb::structs::transactions::BookedServiceEvent;


    #[storage]
    pub struct Storage {
        broker: ContractAddress,
        holders: Vec::<ContractAddress>,
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

        fn open_service(ref self: ComponentState<TContractState>, service_id: felt252) {

        }

        fn book_service(ref self: ComponentState<TContractState>, service_id: felt252) -> felt252 {
            // To book a service, you put in the booking data
            // add a dispute variable. 
            // self.emit(BookedServiceEvent {})
            0
        }
    }

    #[generate_trait]
    pub impl TransactionInternalImpl<
        TContractState, +HasComponent<TContractState>,
    > of TransactionInternalTrait<TContractState> {
        fn token_dispatcher(self: @ComponentState<TContractState>) -> IERC20Dispatcher {
            IERC20Dispatcher {
               contract_address: get_strk_token_address()
            }
        }

        fn _init(ref self: ComponentState<TContractState>) {
            let holders: Array<ContractAddress> = get_holders();
            self.broker.write(get_broker());
            for holder in holders {
                self.holders.append().write(holder);
            };
        }
    }

    // fn open_service(ref self: ComponentState<TContractState>, service_id: felt252, ) {
    //     let caller = get_caller_address();
    //     let service: Service = self._check_id(service_id);
    //     assert!(caller == service.owner, "Error: Caller is not Owner");
    //     let transaction_comp = get_dep_component!(@self, Transaction);
    //     transaction_comp.process
    // }

    // fn book_service(ref self: ComponentState<TContractState>, service_id: felt252) {
    //     let guest: ContractAddress = get_caller_address();
    // assert that the service is open
    // when booked, set the service to closed.

    //     self.service_log.entry(service_id).append().write(guest);
    // }

}