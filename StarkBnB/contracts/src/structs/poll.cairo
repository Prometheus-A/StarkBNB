use starknet::ContractAddress;

// TODO: In the component of this poller, The storage should store a mapped value of an address to a
// Poll To initialize another poll, there should be an algorithm that checks the number of entries
// and address has to return the new amount of voters

// TODO: check the `votes` variable to ensure it stays within `set_votes``
#[derive(Drop, Copy, Serde, PartialEq, starknet::Store)]
pub struct Poll {
    pub id: felt252,
    pub owner: ContractAddress,
    pub set_votes: u64,
    pub votes: (u64, u64),
    pub is_open: bool,
}

#[derive(Drop, starknet::Event)]
pub struct PollStartedEvent {
    #[key]
    pub poll_id: felt252,
    pub owner: ContractAddress,
}

#[derive(Drop, starknet::Event)]
pub struct VotedEvent {
    #[key]
    pub poll_id: felt252,
    pub voter: ContractAddress,
}

#[derive(Drop, starknet::Event)]
pub struct PollConcludedEvent {
    #[key]
    pub poll_id: felt252,
    pub votes: (u64, u64),
}

#[derive(Copy, Drop, PartialEq, Serde)]
pub enum PollType {
    Log,
    Quad,
    Sig,
}
//         # Define constants
// BASE_MIN_VOTES = 10             # Initial minimum votes for the first poll
// MAX_MIN_VOTES = 100             # Upper limit for minimum votes
// CURVE_TYPE = "log"              # Options: "log", "quadratic", "sigmoid"
// STEEPNESS_FACTOR = 2.0          # Controls the overall steepness of the curve (adjustable)

// # Function to calculate minimum voters based on polls initialized
// function calculate_min_votes(polls_initialized):
//     if polls_initialized == 0:
//         return BASE_MIN_VOTES

//     # Apply the selected curve type

// let mut set_votes = 0;
//             if poll_type == PollType::Log {
//                 // Starts steep, slows down over time. Coming soon
//             } else if poll_type == PollType::Quad {
//                 // Starts slow, grows faster over time.
//                 set_votes = BASE_SET_VOTES + STEEPNESS_FACTOR.into() * (polls_initialized.into()
//                 * polls_initialized.into());
//             } else if poll_type == PollType::Sig {
//                 // An S-curve slope
//                 let mut normalized = polls_initialized / (polls_initialized +
//                 STEEPNESS_FACTOR.into());
//                 set_votes = BASE_SET_VOTES + (MAX_SET_VOTES - BASE_SET_VOTES) *
//                 normalized.into();
//             } else {
//                 // default
//             }

//     if CURVE_TYPE == "log":
//         # Logarithmic growth: starts steep, slows down
//         min_votes = BASE_MIN_VOTES + STEEPNESS_FACTOR * log(polls_initialized + 1)

//     elif CURVE_TYPE == "quadratic":
//         # Quadratic growth: starts slow, grows faster over time
//         min_votes = BASE_MIN_VOTES + STEEPNESS_FACTOR * (polls_initialized ^ 2)

//     elif CURVE_TYPE == "sigmoid":
//         # Sigmoid growth: slow at first, steep in the middle, then levels off
//         normalized = polls_initialized / (polls_initialized + STEEPNESS_FACTOR)
//         min_votes = BASE_MIN_VOTES + (MAX_MIN_VOTES - BASE_MIN_VOTES) * normalized

//     else:
//         # Default to linear if no valid curve is selected
//         min_votes = BASE_MIN_VOTES + polls_initialized * STEEPNESS_FACTOR

// # Example usage
// function initialize_poll(user):
//     polls_initialized = get_polls_initialized_by_user(user) # Retrieve user's poll count
//     min_votes = calculate_min_votes(polls_initialized)

//     # Create a poll with the calculated minimum votes
//     poll = create_poll(user, min_votes)
//     increment_user_poll_count(user) # Update poll count for the user

// pub struct Poll {
//     pub id: felt252,
//     pub owner: ContractAddress,
//     pub set_votes: u64,
//     pub is_open: bool
// }
//     return poll


