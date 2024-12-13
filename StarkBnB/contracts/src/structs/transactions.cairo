use starknet::ContractAddress;

#[derive(Drop, Copy, Serde, starknet::Store)]
pub struct Booking {
    pub guest: ContractAddress,
    pub host: ContractAddress,
    pub amount: u256,
    pub service_id: felt252,
    pub check_in_date: u64,
    pub check_out_date: u64,
    pub is_completed: bool,
    pub is_disputed: bool
}

#[derive(Drop, starknet::Event)]
pub struct BookedServiceEvent {
    pub host_address: ContractAddress,
    pub guest_address: ContractAddress,
    pub service_id: felt252,
    pub timestamp: u64
}
