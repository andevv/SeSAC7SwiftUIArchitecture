//
//  CoinViewModel_V3.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/11/25.
//

import Foundation
import Combine

class CoinViewModel_v3: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>() //disposeBag과 같음
    
    private var input = Input()
    
    @Published
    var output = Output()
    
    init() {
        transform()
    }
}

extension CoinViewModel_v3 {
    
    struct Input {
        let viewOnTask = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var market: [Market] = []
    }
    
    enum Action {
        case viewOnTask
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewOnTask:
            input.viewOnTask.send(())
        }
    }
    
    private func transform() {
        input.viewOnTask
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.fetchMarket()
            }
            .store(in: &cancellables)
    }
    
    private func fetchMarket() {
        UpbitAPI.fetchAllMarket { [weak self] data in
            guard let self = self else { return }
            self.output.market = data
        }
    }
    
}
