//
//  EnvExampleView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by andev on 11/12/25.
//

import SwiftUI
import Combine

class SettingModel: ObservableObject {
    @Published var isAlarmOn = false
}

struct EnvExampleView: View {
    
    @StateObject private var setting = SettingModel()
    
    var body: some View {
        VStack {
            Text(setting.isAlarmOn ? "알림 받기" : "알림 받지 않기")
            EnvFirstView()
        }
        .environmentObject(setting)
    }
}

struct EnvFirstView: View {
    var body: some View {
        Text("EnvFirstView")
        EnvSecondView()
    }
}

struct EnvSecondView: View {
    var body: some View {
        Text("EnvSecondView")
        EnvLastView()
    }
}

struct EnvLastView: View {
    
    @EnvironmentObject var settings: SettingModel
    
    var body: some View {
        VStack {
            Text(settings.isAlarmOn ?
                 "알림 받기" : "알림 받지 않기")
            Toggle("알림 설정", isOn: $settings.isAlarmOn)
        }
    }
}

#Preview {
    EnvExampleView()
}
