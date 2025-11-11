//
//  CoinView_v2.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/11/25.
//

import SwiftUI
import Combine

struct CoinView_v2: View {
    
    @StateObject var viewModel = CoinViewModel_v2()

    var body: some View {
        NavigationView {
            ScrollView {
                listView()
            }
            .navigationTitle("My Money")
        }
        .task {
            viewModel.input.viewOnTask.send(())
        }
    }
    
    func listView() -> some View {
        LazyVStack {
            ForEach(viewModel.output.market, id: \.self) { item in
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
    CoinView_v2()
}
