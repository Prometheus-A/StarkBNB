#[starknet::contract]
pub mod Starkbnb {
    use starkbnb::components::{
        host_service::HostHandlerComponent, transaction_service::TransactionHandlerComponent,
        guest_service::GuestHandlerComponent, poll_service::PollHandlerComponent
    };



    // --------------------------------------------------------------------------------------------------------------


    component!(path: HostHandlerComponent, storage: host, event: HostEvent);
    component!(path: TransactionHandlerComponent, storage: transactions, event: TransactionEvent);
    component!(path: GuestHandlerComponent, storage: guest, event: GuestEvent);
    component!(path: PollHandlerComponent, storage: poll, event: PollEvent);

    
    #[abi(embed_v0)]
    impl HostHandlerImpl = HostHandlerComponent::HostHandlerImpl<ContractState>;
    #[abi(embed_v0)]
    impl TransactionHandlerImpl = TransactionHandlerComponent::TransactionHandlerImpl<ContractState>;
    #[abi(embed_v0)]
    impl GuestHandlerImpl = GuestHandlerComponent::GuestHandlerImpl<ContractState>;
    #[abi(embed_v0)]
    impl PollHandlerImpl = PollHandlerComponent::PollHandlerImpl<ContractState>;
    
    
    impl HostHandlerInternalImpl = HostHandlerComponent::HostInternalImpl<ContractState>;
    impl TransactionHandlerInternalImpl = TransactionHandlerComponent::TransactionInternalImpl<ContractState>;
    impl PollHandlerInternalImpl = PollHandlerComponent::PollInternalImpl<ContractState>;



    // ---------------------------------------------------------------------------------------------------------------

    #[storage]
    struct Storage {
        #[substorage(v0)]
        host: HostHandlerComponent::Storage,
        #[substorage(v0)]
        transactions: TransactionHandlerComponent::Storage,
        #[substorage(v0)]
        guest: GuestHandlerComponent::Storage,
        #[substorage(v0)]
        poll: PollHandlerComponent::Storage
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        HostEvent: HostHandlerComponent::Event,
        #[flat]
        TransactionEvent: TransactionHandlerComponent::Event,
        #[flat]
        GuestEvent: GuestHandlerComponent::Event,
        #[flat]
        PollEvent: PollHandlerComponent::Event
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
        self.poll._init();
    }
    
}
