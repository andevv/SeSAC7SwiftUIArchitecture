//
//  CountView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/3/25.
//

import SwiftUI
import Combine

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
