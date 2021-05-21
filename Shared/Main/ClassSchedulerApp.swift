//
//  ClassSchedulerApp.swift
//  Shared
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

#if os(macOS)
@main
struct ClassSchedulerApp: App {
    @NSApplicationDelegateAdaptor var delegator: AppDelegator
    
    var body: some Scene {
        WindowGroup {
            WindowRootView()
            .frame(minWidth: 1200, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
            .ignoresSafeArea()
            .environmentObject(Store())
            .colorScheme(.dark)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
#elseif os(iOS)
@main
struct ClassSchedulerApp: App {
    var body: some Scene {
        WindowGroup {
            MobileRootView()
                .environmentObject(Store())
        }
    }
}
#endif
