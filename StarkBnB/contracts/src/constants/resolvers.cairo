use starknet::{ContractAddress, contract_address_const};
use core::poseidon::PoseidonTrait;
use core::hash::{HashStateTrait, HashStateExTrait};


pub fn get_holders() -> Array<ContractAddress> {    // for test
    let holder_1: ContractAddress = contract_address_const::<'holder1'>();
    let holder_2: ContractAddress = contract_address_const::<'holder2'>();
    array![holder_1, holder_2]
}

pub fn get_broker() -> ContractAddress {
    contract_address_const::<0x05f1a739bFE9af48a75F7a61921E629A769F5DA5a5f5f1821A51E07d633Ad08e>()
}

pub fn get_strk_token_address() -> ContractAddress {
    contract_address_const::<StarknetConstants::STRK_TOKEN_ADDRESS>()
}


pub fn generate_id(name: felt252, owner: ContractAddress) -> felt252 {
    let resolve: Resolve = Resolve { owner, name };
    PoseidonTrait::new().update_with(resolve).finalize()
}

#[derive(Drop, Hash)]
pub struct Resolve {
    pub owner: ContractAddress,
    pub name: felt252
}



pub mod StarknetConstants {
    pub const STRK_TOKEN_ADDRESS: felt252 =
        0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d;
    pub const STRK_TOKEN_MINTER_ADDRESS: felt252 =
        0x0594c1582459ea03f77deaf9eb7e3917d6994a03c13405ba42867f83d85f085d;
}