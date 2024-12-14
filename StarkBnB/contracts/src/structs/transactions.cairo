use starknet::ContractAddress;

#[derive(Drop, Copy, Serde, starknet::Store)]
pub struct Booking {
    pub guest: ContractAddress,
    pub host: ContractAddress,
    pub service_price: u256,
    pub collateral: u256,
    pub service_id: felt252,
    pub check_in_date: u64,
    pub check_out_date: u64,
    pub is_completed: bool,
    pub is_disputed: bool,
    pub timestamp: u64
}

#[derive(Drop, starknet::Event)]
pub struct BookedServiceEvent {
    pub host_address: ContractAddress,
    pub guest_address: ContractAddress,
    pub service_id: felt252,
    pub timestamp: u64
}

#[derive(Drop, Copy, Serde, starknet::Store)]
pub struct Fund {
    pub ref_id: felt252,
    pub owner: ContractAddress,
    pub set_amount: u256,
    pub current_amount: u256,
    pub is_open: bool
}
