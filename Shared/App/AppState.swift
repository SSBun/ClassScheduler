//
//  AppState.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation

struct AppState {
    var lessonList: LessonList = .mock
    var studentList: StudentList = .init()
    var sidebar: Sidebar = .init()
    
    enum SidebarItem: Int, CaseIterable, Identifiable {
        var id: Int { self.rawValue }
        case lessonList
        case studentList
        case settings
        
        var title: String {
            switch self {
            case .lessonList:
                return "课程表"
            case .studentList:
                return "学生管理"
            case .settings:
                return "系统设置"
            }
        }
    }
}

extension AppState {
    struct Sidebar {
        var sidebarSelection: SidebarItem = .lessonList
        var isHidden: Bool = false
    }
}
