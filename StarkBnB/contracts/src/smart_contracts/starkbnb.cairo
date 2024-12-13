#[starknet::contract]
pub mod Starkbnb {
    use starknet::ContractAddress;
    use starkbnb::components::{
        host_service::HostHandlerComponent, transaction_service::TransactionHandlerComponent,
        guest_service::GuestHandlerComponent
    };
    use starkbnb::constants::resolvers::{get_broker, get_holders};

    // ---------------------------------------------------------------------------------------------------------------
    //                                               COMPONENTS
    // ---------------------------------------------------------------------------------------------------------------

    component!(path: HostHandlerComponent, storage: host, event: HostEvent);
    component!(path: TransactionHandlerComponent, storage: transactions, event: TransactionEvent);
    component!(path: GuestHandlerComponent, storage: guest, event: GuestEvent);

    #[abi(embed_v0)]
    impl HostHandlerImpl = HostHandlerComponent::HostHandlerImpl<ContractState>;
    impl HostHandlerInternalImpl = HostHandlerComponent::HostInternalImpl<ContractState>;

    #[abi(embed_v0)]
    impl TransactionHandlerImpl = TransactionHandlerComponent::TransactionHandlerImpl<ContractState>;
    impl TransactionHandlerInternalImpl = TransactionHandlerComponent::TransactionInternalImpl<ContractState>;

    // ---------------------------------------------------------------------------------------------------------------

    #[storage]
    struct Storage {
        #[substorage(v0)]
        host: HostHandlerComponent::Storage,
        #[substorage(v0)]
        transactions: TransactionHandlerComponent::Storage,
        #[substorage(v0)]
        guest: GuestHandlerComponent::Storage
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        HostEvent: HostHandlerComponent::Event,
        #[flat]
        TransactionEvent: TransactionHandlerComponent::Event,
        #[flat]
        GuestEvent: GuestHandlerComponent::Event
    }

    /// Might be edited in the future. The broker is address automated for the sending and
    /// receiving of tokens, both from the host, and the guest, and charges sent to the
    /// third parameter, the devs as holders. Subject to change.
    /// The broker should be lock away after setup, and ownership will be handed to the holders.
    /// TODO: Refine this ownership well.
    #[constructor]
    fn constructor(ref self: ContractState) {
        self.host._init();
        self.transactions._init();
    }
    
}
