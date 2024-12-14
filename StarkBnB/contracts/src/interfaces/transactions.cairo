use starknet::ContractAddress;

#[starknet::interface]
pub trait ITransactionHandler<TContractState> {
    fn open_service(ref self: TContractState, service_id: felt252);
    fn book_service(ref self: TContractState, service_id: felt252) -> felt252;
    fn checkout(ref self: TContractState, service_id: felt252);
}


/// I believe, one thing about booking is, once it is booked, the service is closed, till
/// the guest checks out. Make sure to set the service to closed.
/// In
/// 
/// 
/// 
/// fn book_listing(ref self: TContractState, new_listing: TransactionData);
    // fn initiate_refund(ref self: TContractState, refund_info: TransactionData);
    // fn release_payment(ref self: TContractState, payment_info: TransactionData);
    // fn confirm_check_in(ref self: TContractState, check_in_info: TransactionData);