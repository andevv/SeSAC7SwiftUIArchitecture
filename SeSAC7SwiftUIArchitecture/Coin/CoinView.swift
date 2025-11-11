//
//  CoinView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by Jack on 11/11/25.
//
 
import SwiftUI

struct CoinView: View {
    
    @State private var market: [Market] = []

    var body: some View {
        NavigationView {
            ScrollView {
                listView()
            }
            .navigationTitle("My Money")
        }
        .task {
            UpbitAPI.fetchAllMarket { data in
                market = data
            }
        }
    }
    
    func listView() -> some View {
        LazyVStack {
            ForEach(market, id: \.self) { item in
                rowView(item)
            }
        }
    }
    
    func rowView(_ item: Market) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.koreanName)
                    .fontWeight(.bold)
                Text(item.market)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text(item.englishName)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 6)
    }

}

#Preview {
    CoinView()
}
