//
//  ChartView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/12/25.
//

import SwiftUI

struct ChartView: View {
    
    @StateObject var viewModel = CharViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button("소켓 연결 시작") {
                        WebSocketManager.shared.openWebSocket()
                        WebSocketManager.shared.sendMessage(
                      """
                      [{"ticket":"test"},{"type":"orderbook","codes":["KRW-BTC"]}]
                      """
                        )
                    }
                    Button("소켓 연결 종료") {
                        WebSocketManager.shared.closeWebSocket()
                    }
                }
                ForEach(viewModel.askOrderBook, id: \.id) { item in
                    Text(item.price.formatted())
                }
                .background(Color.blue.opacity(0.2))
                
                ForEach(viewModel.bidOrderBook, id: \.id) { item in
                    Text(item.price.formatted())
                }
                .background(Color.red.opacity(0.2))
            }
        }
    }
}

#Preview {
    ChartView()
}
