//
//  ClassSchedulerApp.swift
//  Shared
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

@main
struct ClassSchedulerApp: App {
    
    @NSApplicationDelegateAdaptor var delegator: AppDelegator
    
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            RootView()
            .frame(minWidth: 1200, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
            .ignoresSafeArea()
            .environmentObject(Store())
            .colorScheme(.dark)
            #else
            LessonListView()
                .environmentObject(Store())
            #endif
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
