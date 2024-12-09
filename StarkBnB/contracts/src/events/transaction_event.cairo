#[event]
#[derive(Drop, starknet::Event)]
pub enum Event {
    ListingBooked: ListingBooked,
    RefundInitiated: RefundInitiated,
    PaymentReleased: PaymentReleased,
    CheckInConfirmed: CheckInConfirmed
}

#[derive(Drop, starknet::Event)]
pub struct ListingBooked {
    #[key]
    pub guest: ContractAddress,
    #[key]
    pub listing_id: felt252,
    pub host: ContractAddress,
    pub booking_amount: felt252,
    pub timestamp: felt252
}

#[derive(Drop, starknet::Event)]
pub struct RefundInitiated {
    #[key]
    pub guest: ContractAddress,
    #[key]
    pub listing_id: felt252,
    pub host: ContractAddress,
    pub booking_amount: felt252,
    pub timestamp: felt252
}

#[derive(Drop, starknet::Event)]
pub struct PaymentReleased {
    #[key]
    pub guest: ContractAddress,
    #[key]
    pub listing_id: felt252,
    pub host: ContractAddress,
    pub booking_amount: felt252,
    pub timestamp: felt252
}

#[derive(Drop, starknet::Event)]
pub struct CheckInConfirmed {
    #[key]
    pub guest: ContractAddress,
    #[key]
    pub listing_id: felt252,
    pub timestamp: felt252
}