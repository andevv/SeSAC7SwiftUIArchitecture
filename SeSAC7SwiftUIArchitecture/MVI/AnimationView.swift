//
//  AnimationView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/13/25.
//

import SwiftUI

struct AnimationView: View {
    
    @State private var isAnimated = false
    
    var body: some View {
        VStack {
            topTitle()
            cardView()
            Button("Animation On") {
                withAnimation(.bouncy) {
                    isAnimated = true
                }
            }
            Button("Animation Off") {
                withAnimation() {
                    isAnimated = false
                }
            }
        }
    }
    
    func topTitle() -> some View {
        Text("Hello World")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: isAnimated ? .leading : .center)
            .overlay(alignment: .trailing) {
                topOverlayButton()
            }
            .padding()
    }
    
    //@ViewBuilder //조건에 따라 뷰가 컴파일타임에 확정되지 못할 때 사용
    func topOverlayButton() -> some View {
        Button {
            withAnimation {
                isAnimated = false
            }
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.white)
                .padding()
                .background(.black, in: Circle())
        }
        .rotationEffect(.degrees(isAnimated ? 225 : 45))
        .opacity(isAnimated ? 1 : 0)
    }
    
    func cardView() -> some View {
        ScrollView {
            ForEach(0..<5) { item in
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 150)
            }
        }
    }
}

#Preview {
    AnimationView()
}
