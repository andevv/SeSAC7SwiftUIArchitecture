//
//  CoinViewModel.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/11/25.
//

import Foundation
import Combine

class CoinViewModel: ObservableObject {
    
    @Published var market: [Market] = []
    
    func fetchMarket() {
        UpbitAPI.fetchAllMarket { data in
            self.market = data
        }
    }
}
