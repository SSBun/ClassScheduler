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
    case selectAppointment(_ appointment: Int)
    
    case requestAppointmentInfo(student: String)
    case requestAppointmentInfoCompletion(_ result: Result<LessonAppointment.Info, CSError>)
    case requestAppointment(_ appointment: Int)
    case requestAppointmentCompletion(_ result: Result<String, CSError>)
    case cancelAppointment(_ appointment: Int)
    case cancelAppointmentCompletion(_ result: Result<String, CSError>)
    
    case switchWeek(_ offset: Int)
    
    case requestStudentInfo(_ id: String)
    case removeStudent(_ id: String)
    case refreshStudentInfo(_ student: Student)
    case searchStudents(_ condition: String)
    case selectStudent(_ id: String)
    
    case importStudents(_ importedData: String)
    
    
    /// Update the course info. If the id is nil, creating a new course.
    case updateCourse(_ id: Int?)
    case removeCourse(_ id: Int)
    /// Update the course poerformance. If the id is nil, creating a new course performance.
    case updateCoursePerformance(_ id: Int?)
    case removeCoursePerformance(_ id: Int)
    /// Update the teacher message. If the id is nil, creating a new teacher message.
    case updateTeacherMessage(_ id: Int?)
    case removeTeacherMessage(_ id: Int)

    case selectCoursePerformance(_ id: Int)
    case selectTeachingMessage(_ id: Int)
    case selectCourse(_ id: Int)
    /// Select or Disselect one course,.If the isEnabled is nil, toggle its state.
    case activateCourse(_ id: Int, _ isEnabled: Bool?)
    case deactivateAllCourse
    case updateEvaluationResult
    
    // MARK: - Settings
    case updateRepeatTimesOfInsertingAnAppointment(_ times: Int)
    case toggleSettingsView(_ display: Bool?)
}
