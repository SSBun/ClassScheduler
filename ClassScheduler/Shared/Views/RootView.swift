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
        HStack(spacing: 0) {
            SidebarView()
            VStack(spacing: 0) {
                NavbarView()
                ZStack {
                    LessonListView().zIndex(store.appState.sidebarSelection == .lessonList ? 1 : 0)
                    StudentListView().zIndex(store.appState.sidebarSelection == .studentList ? 1 : 0)
                    SettingView().zIndex(store.appState.sidebarSelection == .settings ? 1 : 0)
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
