//
//  NumberView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/18/25.
//

import SwiftUI
import Combine
import ComposableArchitecture

/// State, Intent, Store
/// Reducer Protocol -> State, Action, func reduce
@Reducer
struct NumberFeature {
    
    @ObservableState //State 구조체를 SwiftUI가 관찰하고, 뷰가 업데이트 되도록
    struct State {
        var number = 0
    }

    enum Action {
        case increment
        case decrement
    }
    
    // state, action -> Effect
    // 동기 -> 사이드이펙트 X -> 일관된 결과 보장 (return .none)
    // 비동기 -> 사이드이펙트 O -> 일관된 결과 보장 X
    var body: some ReducerOF<Self> {
        Reduce { state, action in
            switch action {
            case .increment:
                state.number += 1
                return .none
            case .decrement:
                state.number -= 1
                return .none
            }
        }
    }
}


struct NumberView: View {
    
    let store: StoreOf<NumberFeature>
    
    var body: some View {
        VStack {
            Text("number: \(store.state.number)")
            HStack {
                Button("-") {
                    store.send(.decrement)
                }
                Button("+") {
                    store.send(.increment)
                }
            }
        }
    }
}

#Preview {
    NumberView(store: Store(initialState: NumberFeature.State(), reducer: {
        NumberFeature()
    }))
}
