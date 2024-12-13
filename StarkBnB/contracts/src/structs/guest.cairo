#[derive(Drop, Copy, Serde, starknet::Store)]
pub struct ServiceLog {
    pub service_id: felt252,
    pub vote: u8
}