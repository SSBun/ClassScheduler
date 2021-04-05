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
            Rectangle()
                .fill(Color.orange)
            Text("Settings")
                .font(.largeTitle)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
