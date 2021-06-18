//
//  RootView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

/// Used in MacOS
struct WindowRootView: View {
    @EnvironmentObject var store: Store
    
    @State private var isHidden: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            SidebarView()
                .isHidden(isHidden, remove: true)
            VStack(spacing: 0) {
                NavbarView()
                ZStack {
                    LessonListView()
                        .zIndex(store.appState.sidebar.sidebarSelection == .lessonList ? 1 : 0)
                    StudentListView()
                        .zIndex(store.appState.sidebar.sidebarSelection == .studentList ? 1 : 0)
                    CourseEvaluationView()
                        .zIndex(store.appState.sidebar.sidebarSelection == .courseEvaluation ? 1 : 0)
                }
                .clipped()
            }
        }
        .sheet(isPresented: $store.appState.settings.isPresented, content: {
            SettingView()
        })
        .onReceive(store.$appState.map(\.sidebar.isHidden)) { value in
            withAnimation {
                isHidden = value
            }
        }
        .onAppear {
            LOG("RootView on appear")
            store.dispatch(.loadApp(nil))
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        WindowRootView()
    }
}
