#[starknet::contract]
pub mod Starkbnb {
    use starknet::ContractAddress;
    use starknet::storage::{
        Map, StoragePathEntry, Vec, StoragePointerReadAccess, VecTrait, MutableVecTrait,
        StoragePointerWriteAccess
    };
    use starkbnb::structs::host::{Service, BookedServiceEvent};
    use starkbnb::components::host_service::HostHandlerComponent;

    // --------------------------------------------- Components
    // ------------------------------------------------------

    component!(path: HostHandlerComponent, storage: host, event: HostEvent);

    #[abi(embed_v0)]
    impl HostHandlerImpl = HostHandlerComponent::HostHandlerImpl<ContractState>;
    impl HostHandlerInternalImpl = HostHandlerComponent::HostInternalImpl<ContractState>;

    // ---------------------------------------------------------------------------------------------------------------

    #[storage]
    struct Storage {
        broker: ContractAddress,
        holders: Vec::<ContractAddress>,
        #[substorage(v0)]
        host: HostHandlerComponent::Storage
    }

    // TODO: Make sure a 'booked service' event is available.
    // Guest's side, take note.
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        HostEvent: HostHandlerComponent::Event
    }

    /// Might be edited in the future. The broker is address automated for the sending and
    /// receiving of tokens, both from the host, and the guest, and charges sent to the
    /// third parameter, the devs as holders. Subject to change.
    /// The broker should be lock away after setup, and ownership will be handed to the holders.
    /// TODO: Refine this ownership well.
    #[constructor]
    fn constructor(
        ref self: ContractState, broker: ContractAddress, holders: Array<ContractAddress>
    ) {
        // contract_service::initialize_contract(broker, holders);
        self.broker.write(broker);
        for holder in holders {
            self.holders.append().write(holder);
        };
        self.host._initialize();
    }
}
