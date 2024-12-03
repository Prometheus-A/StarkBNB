use starkbnb::structs::poller::Poll;

// These are the values we'll be using for now.
pub const BASE_SET_VOTES: u64 = 50;

pub const MAX_SET_VOTES: u64 = 2000;

pub const STEEPNESS_FACTOR: u8 = 3;


pub fn get_empty_poll() -> Poll {
    Poll { id: 0, owner: 'null'.try_into().unwrap(), set_votes: 0, votes: (0, 0), is_open: false }
}
