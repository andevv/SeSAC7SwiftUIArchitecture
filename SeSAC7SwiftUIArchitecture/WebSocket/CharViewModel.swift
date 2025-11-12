//
//  CharViewModel.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/12/25.
//

import Foundation
import Combine

/// 서버에서 받은 디코딩 데이터를 다시 뷰에 표현하기 위한 모델
struct OrderbookItem: Hashable, Identifiable {
    let id = UUID()
    let price: Double
    let size: Double
}

final class CharViewModel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    
    @Published var askOrderBook: [OrderbookItem] = []
    
    @Published var bidOrderBook: [OrderbookItem] = []
    
    init() {
        WebSocketManager.shared.orderbookSbj
            .sink { [weak self] order in
                
                guard let self else { return }
                
                self.askOrderBook = order.orderbook_units
                    .map {
                        .init(price: $0.ask_price, size: $0.ask_size)
                    }
                    .sorted { $0.price > $1.price }
                
                self.bidOrderBook = order.orderbook_units
                    .map {
                        .init(price: $0.bid_price, size: $0.bid_size)
                    }
                    .sorted { $0.price > $1.price }
            }
            .store(in: &cancellable)
    }
    
}
