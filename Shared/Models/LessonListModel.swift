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
    var weekOffset: Int = 0
    var week: CourseCalendar.Week  { CourseCalendar.getWeek(weekOffset) }
    var colTypes: [ColumnType] { week.days.map({ ColumnType.week($0)}) }
    var rowTypes: [ColumnAreaType] = TimeRanges.allCases.map { .timeRange($0) }
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

extension LessonList {
    static let mock: LessonList = .init(columns: CourseCalendar.getWeek(0).days.map({ day in
        Column(type: .week(day), areas: TimeRanges.allCases.map({ timeRange in
            ColumnArea(type: .timeRange(timeRange), items: [AppointmentBlock(appointment: .init(day: day, timeRange: timeRange, student: .mock))])            
        }))
    }))
}

protocol Block: Codable {
    var id: String { get }
}

enum TimeRanges: Int, Codable, CaseIterable {
    case one = 0
    case two
    case three
    case four
    case five
    
    var range: (String, String) {
        switch self {
        case .one:
            return ("09:00", "10:30")
        case .two:
            return ("11:00", "12:30")
        case .three:
            return ("14:00", "15:30")
        case .four:
            return ("17:30", "19:00")
        case .five:
            return ("19:30", "21:00")
        }
    }
}
