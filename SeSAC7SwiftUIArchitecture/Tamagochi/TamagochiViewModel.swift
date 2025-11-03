//
//  TamagochiViewModel.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/3/25.
//

import Foundation
import Combine

@Observable
class TamagochiViewModel: ObservableObject {
    var rice = 0
    var water = 0
    var riceField = ""
    var waterField = ""
    
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
