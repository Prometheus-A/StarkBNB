use core::starknet::SyscallResultTrait;
use snforge_std::{declare, ContractClassTrait, DeclareResultTrait, DeclareResult};
use starkbnb::interfaces::host::{IHostHandlerDispatcher, IHostHandlerDispatcherTrait};

#[test]
fn test_something() {
    let contract = match declare("starkbnb").unwrap() {
        DeclareResult::Success(class) => class,
        DeclareResult::AlreadyDeclared(class) => class,
    };

    let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
    let dispatcher = IHostHandlerDispatcher { contract_address };
    let (_, id_1) = dispatcher.upload_service('bob');
    /// Should return a valid service_id
        /// When testing, test the <service>.data.name if it corresponds to what was used to
        /// intialize the service
    println!("{}", id_1);
    let (is_open, _) = dispatcher.is_open(id_1);
    assert(!is_open, 'Err: Service is open');
}
