pub mod interfaces {
    pub mod guest;
    pub mod host;
    pub mod poller;
    pub mod transactions;
}

pub mod components {
    pub mod guest_service;
    pub mod host_service;
    pub mod contract_service;
    pub mod transaction_service;
}

pub mod smart_contracts {
    pub mod poller;
    pub mod starkbnb;
}

pub mod structs {
    pub mod guest;
    pub mod host;
    pub mod poller;
    pub mod transactions;
}

pub mod constants {
    pub mod host_constants;
    pub mod poll_constants;
    pub mod resolvers;
}

pub mod events {
    pub mod transaction_event;
}

