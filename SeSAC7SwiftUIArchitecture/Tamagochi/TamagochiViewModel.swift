//
//  TamagochiViewModel.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/3/25.
//

import Foundation
import Combine

// @Published: 프로퍼티 데이터가 변경될 때 뷰가 업데이트 되도록 도와주는 키워드
class TamagochiViewModel: ObservableObject {
    @Published var rice = 0
    @Published var water = 0
    @Published var riceField = ""
    @Published var waterField = ""
    
    func addRice() {
        if let count = Int(riceField) {
            rice += count
        } else {
            rice += 1
        }
    }
    
    func addWater() {
        if let count = Int(waterField) {
            water += count
        } else {
            water += 1
        }
    }
}
