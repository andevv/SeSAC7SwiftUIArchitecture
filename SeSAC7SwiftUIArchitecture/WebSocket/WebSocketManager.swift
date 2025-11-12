//
//  WebSocketManager.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/12/25.
//

import Foundation

final class WebSocketManager: NSObject {
    static let shared = WebSocketManager()
    
    private var websocket: URLSessionWebSocketTask?
    
    func openWebSocket() {
        let url = URL(string: "wss://api.upbit.com/websocket/v1")!
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        websocket = session.webSocketTask(with: url)
        websocket?.resume()
    }
    
    func closeWebSocket() {
        websocket?.cancel(with: .goingAway, reason: nil)
        websocket = nil
    }
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print(#function, "OPEN")
        receiveSocketData()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print(#function, "CLOSE")
    }
}

extension WebSocketManager {
    
    func sendMessage(_ string: String) {
        websocket?.send(.string(string)) { error in
            print("Send")
        }
    }
    
    /// 재귀적인 구조로 구성이 되어야 계속해서 데이터를 수신할 수 있음
    func receiveSocketData() {
        websocket?.receive { result in
            print(result)
            self.receiveSocketData()
        }
    }
}
