#[starknet::component]
pub mod PollHandlerComponent {
    use starknet::{ContractAddress, get_caller_address};
    use starknet::storage::{
        Map, StoragePathEntry, Vec, StoragePointerReadAccess, VecTrait, MutableVecTrait,
        StoragePointerWriteAccess,
    };
    use starkbnb::structs::poll::{Poll, VotedEvent, PollType, PollStartedEvent, PollConcludedEvent};
    use starkbnb::constants::poll_constants::{
        BASE_SET_VOTES, MAX_SET_VOTES, STEEPNESS_FACTOR, get_empty_poll,
    };
    use starkbnb::constants::resolvers::generate_id;
    use starkbnb::interfaces::poll::IPollHandler;
    /// voters -- maps the poll id to a list of voters
    /// polls -- maps a poll id to a tuple of Poll and a bool of if the Poll exists
    /// caller -- used for calculationg set_votes
    /// total_no_of_polls -- number of polls created so far
    #[storage]
    pub struct Storage {
        voters: Map::<felt252, Map<ContractAddress, bool>>,
        polls: Map::<felt252, (Poll, bool)>,
        caller: Map::<ContractAddress, u16>,
        total_no_of_polls: u64,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        PollStartedEvent: PollStartedEvent,
        VotedEvent: VotedEvent,
        PollConcludedEvent: PollConcludedEvent,
    }

    #[embeddable_as(PollHandlerImpl)]
    pub impl PollHandler<
        TContractState, +HasComponent<TContractState>,
    > of IPollHandler<ComponentState<TContractState>> {
        fn initialize_poll(
            ref self: ComponentState<TContractState>,
            name: felt252,
            poll_type: PollType,
            base_set_voters: u64,
            max_set_voters: u64,
        ) -> Poll {
            // Coming Soon
            get_empty_poll()
        }

        fn vote(ref self: ComponentState<TContractState>, poll_id: felt252, direction: bool) {
            let (mut poll, exists) = self.polls.entry(poll_id).read();
            assert(exists, 'Error: Poll does not exist');
            assert(poll.is_open, 'Error: Poll is not open');
            let voter = get_caller_address();
            let voted: bool = self.voters.entry(poll_id).read(voter);
            assert!(!voted, "Caller is not allowed to vote twice.");

            let (mut up, mut down): (u64, u64) = poll.votes;
            match direction {
                true => up = up + 1,
                false => down = down + 1,
            };

            poll.votes = (up, down);
            self.voters.entry(poll_id).write(voter, true);
            self.emit(VotedEvent { poll_id, voter });

            if up + down == poll.set_votes {
                poll.is_open = false;
                self.emit(PollConcludedEvent { poll_id, votes: poll.votes });
            }

            self.polls.entry(poll_id).write((poll, true));
        }

        fn get_open_polls(self: @ComponentState<TContractState>) -> Array<Poll> {
            /// voters -- maps the poll id to a list of voters
            /// polls -- maps a poll id to a tuple of Poll and a bool of if the Poll exists
            /// caller -- used for calculationg set_votes
            /// total_no_of_polls -- number of polls created so far
            // #[storage]
            // pub struct Storage {
            //     voters: Map::<felt252, Map<ContractAddress, bool>>,
            //     polls: Map::<felt252, (Poll, bool)>,
            //     caller: Map::<ContractAddress, u16>,
            //     total_no_of_polls: u64

            // }
            let mut polls: Array<Poll> = array![];
            polls
        }

        fn get_poll_by_owner(
            self: @ComponentState<TContractState>, owner: ContractAddress,
        ) -> Array<Poll> {
            let mut polls: Array<Poll> = array![];
            polls
        }

        fn get_all_polls(self: @ComponentState<TContractState>) -> Array<Poll> {
            let mut polls: Array<Poll> = array![];
            polls
        }
    }


    #[generate_trait]
    pub impl PollInternalImpl<
        TContractState, +HasComponent<TContractState>,
    > of PollInternalTrait<TContractState> {
        fn _init(ref self: ComponentState<TContractState>) {
            self.total_no_of_polls.write(0);
        }
        fn _initialize_default_poll(
            ref self: ComponentState<TContractState>,
            poll_type: PollType,
            name: felt252,
            owner: ContractAddress,
        ) -> Poll {
            let mut set_votes: u64 = self._calculate_set_votes(poll_type, owner);
            let id: felt252 = generate_id(name, owner);
            let (poll, exists) = self.polls.entry(id).read();
            // for testing
            assert!(poll == get_empty_poll(), "Poll is not empty.");
            assert!(!exists, "Poll with id already exists.");

            // let owner: ContractAddress = get_caller_address();
            let poll: Poll = Poll { id, owner, set_votes, votes: (0, 0), is_open: false };

            let mut no_of_polls: u64 = self.total_no_of_polls.read();
            self.total_no_of_polls.write(no_of_polls + 1);
            self.polls.entry(id).write((poll, true));
            poll
        }

        fn _calculate_set_votes(
            ref self: ComponentState<TContractState>, poll_type: PollType, caller: ContractAddress,
        ) -> u64 {
            // let caller: ContractAddress = get_caller_address();
            let polls_initialized: u16 = self.caller.entry(caller).read();
            if polls_initialized == 0 {
                return BASE_SET_VOTES;
            }

            let mut set_votes: u64 = match poll_type {
                PollType::Log => 0, // Coming Soon
                PollType::Quad => {
                    BASE_SET_VOTES
                        + STEEPNESS_FACTOR.into()
                            * (polls_initialized.into() * polls_initialized.into())
                },
                PollType::Sig => {
                    let mut normalized = polls_initialized
                        / (polls_initialized + STEEPNESS_FACTOR.into());
                    BASE_SET_VOTES + (MAX_SET_VOTES - BASE_SET_VOTES) * normalized.into()
                },
                _ => (BASE_SET_VOTES + polls_initialized.into() * STEEPNESS_FACTOR.into()),
            };

            if set_votes > MAX_SET_VOTES {
                return MAX_SET_VOTES;
            }

            return set_votes;
        }

        fn _set_open(ref self: ComponentState<TContractState>, poll_id: felt252) {
            let (mut poll, exists) = self.polls.entry(poll_id).read();
            assert(exists, 'Error: Poll does not exist');
            let owner = poll.owner;
            let mut no_of_polls_created: u16 = self.caller.entry(owner).read();
            poll.is_open = true;
            self.polls.entry(poll_id).write((poll, true));
            self.caller.entry(owner).write(no_of_polls_created + 1);
            self.emit(PollStartedEvent { poll_id, owner });
        }
    }
}

