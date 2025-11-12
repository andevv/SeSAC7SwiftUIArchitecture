//
//  ExampleView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/12/25.
//

import SwiftUI
import Combine

struct ExampleState {
    var count = 0
    var nickname = ""
    var inputText = "" //읽기만 할 수 있고 쓸 수는 없음
}

enum ExampleIntent {
    case reset
    case plus
    case minus
    case random
    case input(String)
}

final class ExampleStore: ObservableObject {
    
    @Published private(set) var state = ExampleState()
    
    func action(_ intent: ExampleIntent) {
        switch intent {
        case .reset:
            state.count = 0
        case .plus:
            state.count += 1
        case .minus:
            state.count -= 1
        case .random:
            randomNickname()
        case .input(let text):
            state.inputText = text
        }
    }
    
    private func randomNickname() {
        let list = ["고래밥", "칙촉", "카스타드"]
        state.nickname = list.randomElement()!
    }
}

struct ExampleView: View {
    
    @StateObject private var store = ExampleStore()
    @State private var nickname = ""
    
    var body: some View {
        VStack {
            TextField("테스트 텍스트필드", text: Binding(
                get: { store.state.inputText },
                set: { store.action(.input($0)) }
            ))
            Text(store.state.nickname)
            Button("닉네임 추천") {
                store.action(.random)
            }
            Text("\(store.state.count)")
            HStack {
                Button("리셋") {
                    store.action(.reset)
                }
                Button("플러스") {
                    store.action(.plus)
                }
                Button("마이너스") {
                    store.action(.minus)
                }
            }
        }
    }
}

#Preview {
    ExampleView()
}
