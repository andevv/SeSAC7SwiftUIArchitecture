//
//  BasicView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/12/25.
//

import SwiftUI

struct BasicView: View {
    
    @State private var count = 0
    
    var body: some View {
        VStack {
            Text("Count: \(count)")
            BasicChildFirstView(count: $count)
        }
    }
}

struct BasicChildFirstView: View {
    
    @Binding var count: Int //전달해주기 위해서만 존재
    
    var body: some View {
        VStack {
            Text("BasicChildFirstView")
            BasicChildSecondView(count: $count)
        }
    }
}

struct BasicChildSecondView: View {
    
    @Binding var count: Int
    
    var body: some View {
        VStack {
            Text("BasicChildSecondView")
            BasicLastView(count: $count)
        }
    }
}

struct BasicLastView: View {
    
    @Binding var count: Int
    
    var body: some View {
        Button("버튼 클릭") {
            count += 1
        }
    }
}

#Preview {
    BasicView()
}
