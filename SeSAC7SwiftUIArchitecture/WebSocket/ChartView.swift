//
//  ChartView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/12/25.
//

import SwiftUI

struct ChartView: View {
    var body: some View {
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
            ForEach(0..<10) { item in
                Text("123,456,789")
            }
        }
    }
}

#Preview {
    ChartView()
}
