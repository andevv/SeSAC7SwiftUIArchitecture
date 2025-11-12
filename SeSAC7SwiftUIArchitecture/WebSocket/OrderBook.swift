//
//  OrderBook.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/12/25.
//

import Foundation

struct OrderBook: Hashable, Decodable {
   // let market: String
    let timestamp: Int
    let total_ask_size: Double
    let total_bid_size: Double
    let orderbook_units: [OrderbookUnit]
}

struct OrderbookUnit: Hashable, Decodable {
    let ask_price, ask_size: Double
    let bid_price, bid_size: Double
}
