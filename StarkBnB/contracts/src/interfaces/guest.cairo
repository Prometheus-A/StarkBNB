use starknet::ContractAddress;

/// vote_service -- handles the voting up and down of services. Takes in the service_id, and the
/// direction of
///     the vote.
///
/// get_ranked_services -- services that have been ranked by the previous voting function.
///
/// set_access_list -- takes in the service_id and a bool variable -- true for blacklist, false for
///     whitelist.
#[starknet::interface]
pub trait IGuestHandler<TContractState> {
    fn vote_service(ref self: TContractState, service_id: felt252, direction: bool);

    fn get_ranked_services(self: @TContractState, direction: bool) -> Array<felt252>;
    fn set_access_list(ref self: TContractState, service_id: felt252, blacklist: bool);
}
