//
//  AppState.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation

struct AppState {
    var lessonList: LessonList = .init(columns: [], weekOffset: 0)
    var studentList: StudentList = .init()
    var appointmentsData: [Int: LessonAppointment] = [:]
    var sidebar: Sidebar = .init()
    
    enum SidebarItem: Int, CaseIterable, Identifiable {
        var id: Int { self.rawValue }
        case lessonList
        case studentList
        case settings
        
        var info: (String, String) {
            switch self {
            case .lessonList:
                return ("课程表", "calendar")
            case .studentList:
                return ("学生管理", "person.2.fill")
            case .settings:
                return ("系统设置", "gearshape.fill")
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
