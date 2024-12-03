use starknet::ContractAddress;

#[starknet::interface]
pub trait IGuestHandler<TContractState> {
    fn write_customer_details(
        ref self: TContractState, customer_address: ContractAddress
    ) -> (bool, felt252);
}
