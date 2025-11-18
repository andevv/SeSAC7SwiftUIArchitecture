//
//  NumberView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/18/25.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct NumberState {
    var number = 0
}

enum NumberIntent {
    case increment
    case decrement
}

final class NumberStore: ObservableObject {
    @Published private(set) var state = NumberState()
    
    func action(_ intent: NumberIntent) {
        switch intent {
        case .increment:
            state.number += 1
        case .decrement:
            state.number -= 1
        }
    }
}

struct NumberView: View {
    
    @State private var store = NumberStore()
    
    var body: some View {
        VStack {
            Text("number: \(store.state.number)")
            HStack {
                Button("-") {
                    store.action(.decrement)
                }
                Button("+") {
                    store.action(.increment)
                }
            }
        }
    }
}

#Preview {
    NumberView()
}
