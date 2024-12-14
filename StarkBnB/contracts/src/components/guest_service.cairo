/// All codes and algorithms for the guest are written here.
/// No need to emit an event when a guest books a house.
/// Emit an event each time a new user joins the platform...no?
/// 

/// TODO: Change the name of this componet and the file containing it. Then resolve the whole codebase
#[starknet::component]
pub mod GuestHandlerComponent {
    use HostHandlerComponent::HostInternalTrait;
    use starknet::storage::{
        Map, StoragePathEntry, Vec, StoragePointerReadAccess, VecTrait, MutableVecTrait,
        StoragePointerWriteAccess
    };
    use starknet::{ContractAddress, get_caller_address};
    use starkbnb::components::host_service::{HostHandlerComponent, HostHandlerComponent::HostInternalImpl};
    use starkbnb::interfaces::guest::IGuestHandler;
    use starkbnb::components::transaction_service::{
        TransactionHandlerComponent, TransactionHandlerComponent::TransactionInternalImpl
    };
    use starkbnb::structs::guest::ServiceLog;

    const ERROR: felt252 = 'Err: Invalid direction';

    #[storage]
    pub struct Storage {
        votes: Map::<ContractAddress, Vec::<ServiceLog>>,
        service_logs: Map::<felt252, (u16, u16)>
    }

    #[embeddable_as(GuestHandlerImpl)]
    impl GuestHandler<
        TContractState, +HasComponent<TContractState>, +Drop<TContractState>,
        impl Host: HostHandlerComponent::HasComponent<TContractState>, 
        impl Transaction: TransactionHandlerComponent::HasComponent<TContractState>
    > of IGuestHandler<ComponentState<TContractState>>  {
        
        fn vote_service(ref self: ComponentState<TContractState>, service_id: felt252, direction: bool) {
            let caller: ContractAddress = get_caller_address();
            let mut hostc = get_dep_component_mut!(ref self, Host);
            let mut found: bool = false;
            let _ = hostc._check_id(service_id);
            let address_vec = hostc.service_log.entry(service_id);
            for i in 0..address_vec.len() {
                if caller == address_vec.at(i).read() {
                    found = true;
                    break;
                }
            };

            assert!(found, "Err: Caller Access Denied. Are you sure you have used this service?");
            
            let votes = self.votes.entry(caller);
            let mut vote: u8 = 1;   // 0 for false, 1 null, 2 true.
            let mut found: bool = false;
            for i in 0..votes.len() {
                let service_log = votes.at(i).read();
                if service_log.service_id == service_id {
                    vote = service_log.vote;
                    found = true;
                    break;
                }
            };

            let (mut up, mut down) = self.service_logs.entry(service_id).read();
            vote = match direction {
                true =>  {
                    assert(vote == 0 || vote == 1, ERROR);
                    up = up + 1;
                    2
                },
                false => {
                    assert(vote == 1 || vote == 2, ERROR);
                    down = down + 1;
                    0
                }
            };

            self.service_logs.entry(service_id).write((up, down));
            let service_log_ref: ServiceLog = ServiceLog { service_id, vote };
            
            if !found {
                self.votes.entry(caller).append().write(service_log_ref);
            } else {
                for i in 0..votes.len() {
                    let service_log: ServiceLog = votes.at(i).read();
                    if service_log.service_id == service_id {
                        votes.at(i).write(service_log_ref);
                        break;
                    }
                };
            }

            // Emit an event in the future.

        }

        fn get_ranked_services(self: @ComponentState<TContractState>, direction: bool) -> Array<felt252> {
            // return an array of service ids.
            array![]
        }

        fn set_access_list(ref self: ComponentState<TContractState>, service_id: felt252, blacklist: bool) {
            // white or black
            // for whitelisting, assert the caller is the owner.
            // for the blacklisting, at the end of the day, set the is_elegible value of the service
            // to false
            // at the end of the day, a staking pool is opened, and if the set_amount is reached, a default
            // poll is created for the voting. The winner lives, the loser dies.

            // initialize poll from here, or from transactions
            // but make sure you put in the PollType
        }
    }

    // TODO: 
}


