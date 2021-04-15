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
    var courseEvaluation: CourseEvaluation = .init()
    
    enum SidebarItem: Int, CaseIterable, Identifiable {
        var id: Int { self.rawValue }
        case lessonList
        case courseEvaluation
        case studentList
        
        var info: (String, String) {
            switch self {
            case .lessonList:
                return ("课程表", "calendar")
            case .studentList:
                return ("学生管理", "person.2.fill")
            case .courseEvaluation:
                return ("课程评价", "text.bubble.fill")
            }
        }
    }
}

extension AppState {
    struct Sidebar {
        var sidebarSelection: SidebarItem = .courseEvaluation
        var isHidden: Bool = false
    }
}
