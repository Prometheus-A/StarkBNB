/// Here are all the structs used for the host, HOST structs and events, and the house listings
/// would be embedded here.

use starknet::ContractAddress;

/// This is the main struct of the host's service (house) details to be stored.
///     1. owner -- The contract address of the owner
///     2. servicd_id -- The id of the Service class.
///     3. data -- the service data of struct ServiceData

///     STORAGE     STORAGE     STORAGE     STORAGE     STORAGE     STORAGE     STORAGE     STORAGE
///     Each owner must have the id to their property for greater security. For  transfer of
///     ownership Tell caller to input the id.
#[derive(Drop, Copy, Serde, starknet::Store)]
pub struct Service {
    pub owner: ContractAddress,
    pub id: felt252,
    pub data: ServiceData
}

///     1. name -- The name associated with this service
///     2. wishlist_count -- The number of addresses that added this to their wishlist. Ranks it by
///        popular together with the booking rate of a certain value to be completed by a function
///        in
///     3. booking_rate -- would be calculated in the future, initially set to zero
///        has staked an amount, and closed when the service has been booked, and the cycle repeats
///        itself.
///     4. cost -- cost of service injected by the owner
///     5. stake -- stake amount sent by the owner to the broker. TODO: These two values shall be
///        compared in the future.
///     6. votes -- The number of votes this service has
///     7. is_open -- And tuple of whether or not is occupied/open, and the no. of days booked if
///     closed.
///
///     8. is_eligible -- defaults to true on upload. To be assigned based on a criteria in the
///     future.
///

#[derive(Drop, Copy, Serde, starknet::Store)]
pub struct ServiceData {
    pub name: felt252,
    pub wishlist_count: u64,
    pub booking_rate: u8,
    pub cost: u256,
    pub stake: u128,
    pub votes: i128,
    pub is_open: (bool, u64),
    pub is_eligible: bool
}

#[derive(Drop, Hash)]
pub struct ServiceResolve {
    pub name: felt252,
    pub salt: felt252
}

/// Crosscheck if a struct for storage, that stores all house listings

/// An Event struct to be emitted each time a service is booked or uploaded.
/// Consider moving this event to the Guest's side.
///
///
///
///
/// EVENT       EVENT       EVENT       EVENT       EVENT       EVENT       EVENT       EVENT
#[derive(Drop, starknet::Event)]
pub struct BookedServiceEvent {
    pub host_address: ContractAddress,
    pub guest_address: ContractAddress,
    pub service_id: felt252,
    pub timestamp: u64
}

#[derive(Drop, starknet::Event)]
pub struct UploadedServiceEvent {
    pub id: felt252,
    pub host_address: ContractAddress
}

#[derive(Drop, starknet::Event)]
pub struct OwnershipTransferredEvent {
    pub service_id: felt252,
    pub old_host: ContractAddress,
    pub new_host: ContractAddress,
    pub timestamp: u64
}

