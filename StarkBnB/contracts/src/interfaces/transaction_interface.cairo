#[starknet::interface]
pub trait ITransactionHandler<TContractState> {
    fn book_listing(ref self: TContractState, new_listing: TransactionData);
    fn initiate_refund(ref self: TContractState, refund_info: TransactionData);
    fn release_payment(ref self: TContractState, payment_info: TransactionData);
    fn confirm_check_in(ref self: TContractState, check_in_info: TransactionData);
}