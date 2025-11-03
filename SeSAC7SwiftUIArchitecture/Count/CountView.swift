//
//  CountView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/3/25.
//

import SwiftUI
import Combine


// StateObject(하위뷰 값 유지) vs ObservedObject(하위뷰 초기화)
// State > body > 인스턴스가 새롭게 생성 -> 초기화처럼 보임
// iOS17+ @Observable로 통합됨
struct CountView: View {
    
    @State private var nicknameField = ""
    
    var body: some View {
        VStack {
            TextField("닉네임을 입력해보세요", text: $nicknameField)
            ChildCountView()
        }
    }
}

struct ChildCountView: View {
    
    @StateObject private var viewModel = ChildCountViewModel()
    
    var body: some View {
        HStack {
            Text("숫자: \(viewModel.count)")
            Button("클릭") {
                viewModel.incrementCount()
            }
        }
    }
}

class ChildCountViewModel: ObservableObject {
    
    @Published var count = 0
    
    func incrementCount() {
        count += 1
    }
    
}

#Preview {
    CountView()
}
