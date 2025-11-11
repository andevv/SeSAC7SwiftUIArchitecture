//
//  CoinView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by Jack on 11/11/25.
//
 
import SwiftUI

struct CoinView: View {
    
    @StateObject var viewModel = CoinViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                listView()
            }
            .navigationTitle("My Money")
        }
        .task {
            viewModel.fetchMarket()
        }
    }
    
    func listView() -> some View {
        LazyVStack {
            ForEach(viewModel.market, id: \.self) { item in
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
