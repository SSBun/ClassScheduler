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
            LessonListView()
                .frame(minWidth: 300, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
                .environmentObject(Store())
            #else
            LessonListView()
                .environmentObject(Store())
            #endif
        }
    }
}
