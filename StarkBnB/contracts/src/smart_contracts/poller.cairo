#[starknet::contract]
pub mod Poll {
    use starknet::{ContractAddress, get_caller_address};
    use starknet::storage::{
        Map, StoragePathEntry, Vec, StoragePointerReadAccess, VecTrait, MutableVecTrait,
        StoragePointerWriteAccess
    };
    use starkbnb::structs::poller::{
        Poll, VotedEvent, PollResolve, PollType, PollStartedEvent, PollConcludedEvent
    };
    use starkbnb::constants::poll_constants::{
        BASE_SET_VOTES, MAX_SET_VOTES, STEEPNESS_FACTOR, get_empty_poll
    };
    use starkbnb::interfaces::poller::IPollHandler;

    use core::poseidon::PoseidonTrait;
    use core::hash::{HashStateTrait, HashStateExTrait};

    /// First param maps the poll id to a list of voters
    /// Third variable is for calculationg set_votes
    #[storage]
    pub struct Storage {
        voters: Map::<felt252, Map<ContractAddress, bool>>,
        polls: Map::<felt252, (Poll, bool)>,
        caller: Map::<ContractAddress, u16>,
        total_no_of_polls: u64
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        PollStartedEvent: PollStartedEvent,
        VotedEvent: VotedEvent,
        PollConcludedEvent: PollConcludedEvent
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
        self.total_no_of_polls.write(0);
    }

    // *******************************************************************************************************
    //                                      ABI AND INTERNALIMPL
    // *******************************************************************************************************

    #[abi(embed_v0)]
    impl PollHandler of IPollHandler<ContractState> {
        fn initialize_default_poll(ref self: ContractState, name: felt252) -> Poll {
            self._initialize_poll(PollType::Sig, name)
        }

        fn initialize_poll(
            ref self: ContractState,
            name: felt252,
            poll_type: PollType,
            base_set_voters: u64,
            max_set_voters: u64
        ) -> Poll {
            // Coming Soon
            get_empty_poll()
        }

        // voters: Map::<felt252, Map<ContractAddress, bool>>,
        // polls: Map::<felt252, (Poll, bool)>,
        // caller: Map::<ContractAddress, u16>,
        // total_no_of_polls: u64

        fn vote(ref self: ContractState, poll_id: felt252, direction: u8) {// Check if the poll is open
        // the first param. Make sure a voter can't vote twice (assert)
        // vote. add to self.voters variable
        // check if the total no. of votes (up, down) has reach the set_votes, then close the poll,
        // if yes.
        // A voted Event is emitted regardless
        // A VotedConcludedEvent is emitted is 4th is true
        }

        fn get_open_polls(self: @ContractState) -> Array<Poll> {
            let mut polls: Array<Poll> = array![];
            polls
        }

        fn get_poll_by_owner(self: @ContractState, owner: ContractAddress) -> Array<Poll> {
            let mut polls: Array<Poll> = array![];
            polls
        }

        fn get_all_polls(self: @ContractState) -> Array<Poll> {
            let mut polls: Array<Poll> = array![];
            polls
        }
    }


    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn _initialize_poll(ref self: ContractState, poll_type: PollType, name: felt252) -> Poll {
            let mut set_votes: u64 = self._calculate_set_votes(poll_type);
            let id: felt252 = self._generate_id(name);
            let (poll, exists) = self.polls.entry(id).read();
            // for testing
            assert!(poll == get_empty_poll(), "Poll is not empty.");
            assert!(!exists, "Poll with id already exists.");

            let owner: ContractAddress = get_caller_address();
            let poll: Poll = Poll { id, owner, set_votes, votes: (0, 0), is_open: false };

            let mut no_of_polls: u64 = self.total_no_of_polls.read();
            self.total_no_of_polls.write(no_of_polls + 1);
            self.polls.entry(id).write((poll, true));
            poll
        }

        fn _calculate_set_votes(ref self: ContractState, poll_type: PollType) -> u64 {
            let caller: ContractAddress = get_caller_address();
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

        fn _generate_id(ref self: ContractState, name: felt252) -> felt252 {
            let poll_resolve: PollResolve = PollResolve { owner: get_caller_address(), name };
            let poll_id: felt252 = PoseidonTrait::new().update_with(poll_resolve).finalize();
            poll_id
        }

        fn _set_open(ref self: ContractState, poll_id: felt252) {//  Get the owner of the poll
        // Set it in self.caller, and increment the u16 value
        // After, emit a PollStartedEvent
        }
    }
}

