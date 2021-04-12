//
//  AppAction.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation

enum AppAction {
    case loadApp(_ app: AppState?)
        
    case switchSidebar(_ item: AppState.SidebarItem)
    case toggleSidebar(_ hide: Bool?)
    case toggleLessonListSidebar(_ hide: Bool?)

    case moveBlock(_ block: Int, _ toArea: String)
    case insertAppointment(student: String,  to: String)
    
    case switchWeek(_ offset: Int)
    
    case requestStudentInfo(_ id: String)
    case refreshStudentInfo(_ student: Student)
    case searchStudents(_ condition: String)
    
    case importStudents(_ importedData: String)
}
