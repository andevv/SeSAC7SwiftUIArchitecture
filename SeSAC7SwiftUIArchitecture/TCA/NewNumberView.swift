//
//  NewNumberView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/19/25.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct NewNumberFeature {
    
    @ObservableState
    struct State {
        var number = 0
        var nicknameTextField = ""
    }
    
    // 1. BindableAction >> binding
    enum Action: BindableAction {
        case plus
        case minus
        case binding(BindingAction<State>) //양방향 이벤트
    }
    
    // BindingRducer()
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .plus:
                state.number += 10
                return .none
            case .minus:
                state.number -= 10
                return .none
            case .binding:
                return .none
            }
        }
    }
}

struct NewNumberView: View {
    
    @Bindable
    var store: StoreOf<NewNumberFeature>
        
    var body: some View {
        VStack {
            TextField("닉네임을 입력해보세요", text: $store.nicknameTextField)
            Text("입력한 글자: \(store.nicknameTextField)")
            Text("Hello, World! \(store.number)")
            HStack {
                Button("-") {
                    store.send(.minus)
                }
                Button("+") {
                    store.send(.plus)
                }
            }
        }
    }
}

#Preview {
    NewNumberView(store: Store(initialState: NewNumberFeature.State(), reducer: {
        NewNumberFeature()
    }))
}
