//
//  TamagochiView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/3/25.
//

import SwiftUI

struct TamagochiView: View {
    
    @Bindable private var viewModel = TamagochiViewModel()
    
    var body: some View {
        VStack {
            Text("밥알: \(viewModel.rice)개, 물방울: \(viewModel.water)개")
            HStack {
                TextField("밥알을 입력해주세요", text: $viewModel.riceField)
                Button("밥알") {
                    viewModel.addRice()
                }
            }
            HStack {
                TextField("물방울을 입력해주세요", text: $viewModel.waterField)
                Button("물방울") {
                    viewModel.addWater()
                }
            }
        }
    }
}
    
#Preview {
    TamagochiView()
}
