//
//  WebSocketManager.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/12/25.
//

import Foundation
import Combine

final class WebSocketManager: NSObject {
    static let shared = WebSocketManager()
    
    private var websocket: URLSessionWebSocketTask?
    
    private var timer: Timer?
    
    var orderbookSbj = PassthroughSubject<OrderBook, Never>()
    
    func openWebSocket() {
        let url = URL(string: "wss://api.upbit.com/websocket/v1")!
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        websocket = session.webSocketTask(with: url)
        websocket?.resume()
    }
    
    func closeWebSocket() {
        websocket?.cancel(with: .goingAway, reason: nil)
        websocket = nil
        
        timer?.invalidate()
        timer = nil
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
            switch result {
            case .success(let success):
                print("JACK", success)
                
                switch success {
                case .data(let data):
                    
                    if let decodedData = try? JSONDecoder().decode(OrderBook.self, from: data) {
                        dump(decodedData)
                        
                        self.orderbookSbj.send(decodedData)
                    }
                    
                case .string(let string): print(string)
                @unknown default:
                    print("Unknown Default")
                }
                
            case .failure(let failure):
                print(failure)
            }
            self.receiveSocketData()
        }
    }
    
    /// 서버에 의해 연결이 끊어지지 않도록 주기적으로 ping을 서버에 전송
    func sendPing() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { [weak self] _ in
            self?.websocket?.sendPing(pongReceiveHandler: { error in
                if let error = error {
                    print("ping pong error", error.localizedDescription)
                } else {
                    print("ping ping ping")
                }
            })
        })
    }
}
