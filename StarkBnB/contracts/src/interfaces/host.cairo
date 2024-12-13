use starknet::ContractAddress;
use starkbnb::structs::host::Service;

/// For Devs, note:
/// 1.  upload_service uploads a service to the dApp, which will in the future TODO: Start a poll.
///     Automatically returns true with the service_id as a (bool, felt252), else returns the
///     opposite if for some reason the upload fails.
///
/// 2.  update_service -- called to update info on the updated service.
///
/// 3.  is_eligible -- it is automatically set to false (using your implementation anyway) until the
///     poll has been concluded. If in favour with the host, it is set to true, else it remains
///     false.
///     TODO: For a Guest to book a service, always sheck this value.
///
/// 4.  is_open -- returns a tuple -- boolean value if the service is open for use or not, and the
/// no. of days it has
///     been booked from the timestamp
///
/// 5.  transfer_ownership -- Can only be done by the owner. Transfer the ownership of a service to
/// another.
///
/// 6.  delete_service -- deletes a service.
///
/// 7.  vote -- up and down votes of a house @params service_id of the house/service, guest's
/// contract
///     contract address, vote_variable read from the Guest's storage, and direction... true for up,
///     false for down.
///
/// 8.  write_log -- records a log of service ids mapped with the guest address (The guest that used
/// the service)
///     This way voting up and down, rating and reviews of a services can only be done by guests who
///     have used them.
///
/// 9.  get_open_services -- Takes in a page number starting with page 0. Returns an array in
/// batches of 20
///
/// 10. get_all_services --  Takes in a page number too and returns in the same batch
///
/// 11. get_services_by_host --  Takes in the hosts contract address, and returns an array of
/// services associated to that host.
///
/// 12. get_service_by_ids -- Takes in an array of ids, and returns an array of Services that have
/// the required ids
#[starknet::interface]
pub trait IHostHandler<TContractState> {
    fn upload_service(ref self: TContractState, name: felt252) -> (bool, felt252);
    fn update_service(ref self: TContractState, service_id: felt252, cost: u256);
    fn is_eligible(ref self: TContractState, service_id: felt252) -> bool;
    fn is_open(ref self: TContractState, service_id: felt252) -> (bool, u64);
    fn transfer_ownership(ref self: TContractState, new_host: ContractAddress, service_id: felt252);
    fn delete_service(ref self: TContractState, service_id: felt252) -> bool;
    fn get_all_services(self: @TContractState, page: u8) -> Array<Service>;
    fn get_services_by_host(self: @TContractState, host: ContractAddress) -> Array<Service>;
    fn get_service_by_ids(ref self: TContractState, service_ids: Array<felt252>) -> Array<Service>;
    fn log_out(ref self: TContractState, service_id: felt252);
}