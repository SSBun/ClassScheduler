//
//  RootView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: Store    
    
    var body: some View {
        HSplitView {
            if !store.appState.sidebar.isHidden {
                SidebarView()
            }
            VStack(spacing: 0) {
                ZStack {
                    LessonListView()
                        .zIndex(store.appState.sidebar.sidebarSelection == .lessonList ? 1 : 0)
                    StudentListView()
                        .zIndex(store.appState.sidebar.sidebarSelection == .studentList ? 1 : 0)
                    SettingView()
                        .zIndex(store.appState.sidebar.sidebarSelection == .settings ? 1 : 0)
                }
                .clipped()
            }
        }
        .padding(.top, -30)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
