use starknet::ContractAddress;
use starkbnb::structs::poller::{Poll, PollType};
/// The interfaces used on the poller smart contract
/// get votes and compare, if eligible, interact with the starkbnb smart contract
///
/// The caller address is logged and returned in the poll outcome. Here if he loses, the outcome is
/// sent to the starkbnb contract for further processing. The max_voters variable is calculated from
/// the number of entries The caller address has in the poll map in the storage. Should be a steep
/// curve.
///
/// For each vote, log the address. No address should be allowed to vote more than once. Log the
/// caller of this function Emit an event for each vote. NOTE: first assert before each vote if a
/// variable `vote_count` < `max_voters`. Once it equals `max_voters`, immediately compute the
/// outcome.
///
/// set open if the max stake has been reached, then the voting can commence. The initializer should
/// feel free to share the link.
#[starknet::interface]
pub trait IPollHandler<TContractState> {
    fn initialize_default_poll(ref self: TContractState, name: felt252) -> Poll; // OR NOT
    fn initialize_poll(
        ref self: TContractState,
        name: felt252,
        poll_type: PollType,
        base_set_voters: u64,
        max_set_voters: u64
    ) -> Poll;
    fn vote(ref self: TContractState, poll_id: felt252, direction: u8);
    fn get_open_polls(self: @TContractState) -> Array<Poll>;
    fn get_poll_by_owner(self: @TContractState, owner: ContractAddress) -> Array<Poll>;
    fn get_all_polls(self: @TContractState) -> Array<Poll>;
}
//        CHECK THESE FUNCTIONS. TO BE CONTINUED.

/// This poll uses a sigmoid and 20 voters base as default. In the future, you may create a poll
/// with the type of steepness Might be useful in the future, for now we use the base.


