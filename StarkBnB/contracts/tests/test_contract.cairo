use core::starknet::SyscallResultTrait;
use starknet::ContractAddress;
use snforge_std::{
    declare, ContractClassTrait, DeclareResultTrait, DeclareResult, start_cheat_caller_address
};
use starkbnb::interfaces::host::{IHostHandlerDispatcher, IHostHandlerDispatcherTrait};


fn deploy(name: ByteArray) -> ContractAddress {
    let contract = match declare(name).unwrap() {
        DeclareResult::Success(class) => class,
        DeclareResult::AlreadyDeclared(class) => class,
    };

    let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
    contract_address
}

fn get_caller_address(name: felt252) -> ContractAddress {
    name.try_into().unwrap()
}

#[test]
fn test_something() {
    let contract_address: ContractAddress = deploy("starkbnb");
    let dispatcher = IHostHandlerDispatcher { contract_address };
    let (_, id_1) = dispatcher.upload_service('bob');
    /// Should return a valid service_id
    /// When testing, test the <service>.data.name if it corresponds to what was used to
    /// intialize the service
    start_cheat_caller_address(contract_address, 'adminstarkbnb'.try_into().unwrap());
    println!("{}", id_1);
    let (is_open, _) = dispatcher.is_open(id_1);
    assert(is_open, 'Err: Service is open');
}
