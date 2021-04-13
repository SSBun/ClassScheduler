//
//  LessonListModel.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import SwiftUI

struct LessonList {
    var columns: [Column]    
    var weekOffset: Int
    var week: CourseCalendar.Week  { CourseCalendar.getWeek(weekOffset) }
    
    var colTypes: [ColumnType] { week.days.map({ ColumnType.week($0)}) }
    var rowTypes: [ColumnAreaType] = TimeRanges.allCases.map { .timeRange($0) }
    
    var isSidebarHidden: Bool = true
    var appointmentDetail: AppointmentDetail = .init()
}

extension LessonList {
    struct AppointmentDetail {
        var appointment: Int?
        var isRequesting: Bool = false
        var requestedResult: Result<String, CSError>?
    }
}

extension LessonList {
    struct Column: Identifiable {
        var id: String = UUID().uuidString
        
        let type: ColumnType
        var areas: [ColumnArea]
    }
    
    struct ColumnArea: Identifiable {
        var id: String = UUID().uuidString
        
        let type: ColumnAreaType
        let columnType: ColumnType
        var items: [Block]
    }
                   
    enum ColumnType: Identifiable {
        case week(_ week: CourseCalendar.Day)
        
        var id: String {
            switch self {
            case .week(let day):
                return "\(day.date.timeIntervalSince1970)"
            }
        }
    }
    
    enum ColumnAreaType: Identifiable {
        case timeRange(_ range: TimeRanges)
        
        var id: String {
            switch self {
            case .timeRange(let range):
                return "timeRange-\(range.rawValue)"
            }
        }
    }
}

protocol Block: Codable {
    var id: Int { get }
}


