//
//  SettingView.swift
//  ClassScheduler (iOS)
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        ZStack {
            Text("Settings")
                .font(.largeTitle)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
