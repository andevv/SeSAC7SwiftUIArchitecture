//
//  AnimationView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/13/25.
//

import SwiftUI

struct CardModel: Hashable {
    let color = Color.random()
    let name: String
    let number: Int
}

extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
}

struct AnimationView: View {
    
    @State private var isAnimated = false
    @State private var isExpandable = false
    
    @State private var currentCard = CardModel(name: "", number: 0)
    
    @Namespace var animation
    
    var cardlist = [
        CardModel(name: "신한카드", number: 0),
        CardModel(name: "국민카드", number: 1),
        CardModel(name: "대구카드", number: 2),
        CardModel(name: "현대카드", number: 3),
        CardModel(name: "카카오카드", number: 4)
    ]
    
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
        .overlay {
            if isAnimated {
                DetailAnimationView(showDetail: $isAnimated, animation: animation, currentCard: currentCard)
            }
        }
    }
    
    func topTitle() -> some View {
        Text("Hello World")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: isExpandable ? .leading : .center)
            .overlay(alignment: .trailing) {
                topOverlayButton()
            }
            .padding()
    }
    
    //@ViewBuilder //조건에 따라 뷰가 컴파일타임에 확정되지 못할 때 사용
    func topOverlayButton() -> some View {
        Button {
            withAnimation {
                isExpandable = false
            }
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.white)
                .padding()
                .background(.black, in: Circle())
        }
        .rotationEffect(.degrees(isExpandable ? 225 : 45))
        .opacity(isExpandable ? 1 : 0)
    }
    
    func cardView() -> some View {
        ScrollView {
            ForEach(cardlist, id: \.self) { item in
                oneCard(item)
            }
        }
        .overlay {
            Rectangle()
                .fill(.black.opacity(isExpandable ? 0 : 0.01))
                .onTapGesture {
                    withAnimation {
                        isExpandable = true
                    }
                }
        }
    }
    
    func oneCard(_ card: CardModel) -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(card.color)
            .frame(height: 150)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .offset(y: CGFloat(card.number) * (isExpandable ? 0 : -100 ))
            .matchedGeometryEffect(id: card, in: animation)
            .onTapGesture {
                currentCard = card
                withAnimation {
                    isAnimated = true
                }
            }
    }
}

struct DetailAnimationView: View {
    
    @Binding var showDetail: Bool
    
    let animation: Namespace.ID
    
    let currentCard: CardModel
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack {
                Text(currentCard.name)
                RoundedRectangle(cornerRadius: 25)
                    .fill(currentCard.color)
                    .frame(height: 150)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .matchedGeometryEffect(id: currentCard, in: animation)
                    .onTapGesture {
                        withAnimation {
                            showDetail = false
                        }
                    }
            }
        }
    }
}

#Preview {
    AnimationView()
}
