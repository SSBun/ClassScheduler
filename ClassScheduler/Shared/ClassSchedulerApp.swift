//
//  ClassSchedulerApp.swift
//  Shared
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

@main
struct ClassSchedulerApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            RootView()
            .frame(minWidth: 300, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
            .ignoresSafeArea()
            .environmentObject(Store())
            #else
            LessonListView()
                .environmentObject(Store())
            #endif
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
