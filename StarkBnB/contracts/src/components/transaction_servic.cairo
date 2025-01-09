// use starknet::interfaces::{book_listing, initiate_refund, release_payment, confirm_check_in};

// #[starknet::contract]
// pub mod TransactionHandlerComponent {
//     use super::*;
//     use starknet::ContractAddress;

//     use starknet::storage::{
//         StoragePointerReadAccess, StoragePointerWriteAccess, Vec, VecTrait, MutableVecTrait, Map,
//         StorageMapReadAccess, StorageMapWriteAccess
//     };
//     use core::starknet::{ContractAddress, get_caller_address};

//     use starkbnb::transaction_event::{ListingBooked, RefundInitiated, PaymentReleased,
//     CheckInConfirmed};

//     use starkbnb::transaction_struct::TransactionData;

//     use starkbnb::transaction_storage::{
//         transactions, refund_requests, check_in
//     };

//     #[constructor]
//     fn constructor(ref self: ContractState, host: ContractAddress) {
//         self.host.write(host);
//     }

//     #[abi(embed_v0)]
//     impl TransactionHandlerImpl of super::ITransactionHandler<TContractState> {
//         fn book_listing(ref self: ContractState, new_listing: TransactionData) {

//             let caller = get_caller_address();
//             let guest = new_listing.guest;

//             assert(caller == guest, "Only the guest can book a listing");

//             let key = (new_listing.guest, new_listing.listing_id);

//             self.transactions.write(key, new_listing);

//             self.emit(Event::ListingBooked {
//                 guest: new_listing.guest,
//                 listing_id: new_listing.listing_id,
//                 host: new_listing.host,
//                 booking_amount: new_listing.booking_amount,
//                 timestamp: new_listing.timestamp
//             })
//         }

//         fn initiate_refund(ref self: ContractState, refund_info: TransactionData) {

//             let caller = get_caller_address();
//             let guest = refund_info.guest;

//             assert(caller == guest, "Only the guest can initiate a refund");

//             let key = (refund_info.guest, refund_info.listing_id);

//             self.refund_requests.write(key, refund_info);

//             self.emit(Event::RefundInitiated {
//                 guest: refund_info.guest,
//                 listing_id: refund_info.listing_id,
//                 host: refund_info.host,
//                 booking_amount: refund_info.booking_amount,
//                 timestamp: refund_info.timestamp
//             })
//         }

//         fn release_payment(ref self: ContractState, payment_info: TransactionData) {
//             let caller = get_caller_address();
//             let host = payment_info.host;

//             assert(caller == host, "Only the host can release a payment");

//             let key = (payment_info.guest, payment_info.listing_id);

//             self.transactions.write(key, {});

//             self.emit(Event::PaymentReleased {
//                 guest: payment_info.guest,
//                 listing_id: payment_info.listing_id,
//                 host: payment_info.host,
//                 booking_amount: payment_info.booking_amount,
//                 timestamp: payment_info.timestamp
//             })
//         }

//         fn confirm_check_in(ref self: ContractState, check_in_info: TransactionData) {
//             let caller = get_caller_address();
//             let guest = check_in_info.guest;

//             assert(caller == guest, "Only the guest can confirm check-in");

//             let key = (check_in_info.guest, check_in_info.listing_id);

//             self.check_in.write(key, true);

//             self.emit(Event::CheckInConfirmed {
//                 guest: check_in_info.guest,
//                 listing_id: check_in_info.listing_id,
//                 timestamp: check_in_info.timestamp
//             })
//         }
//     }
// }
