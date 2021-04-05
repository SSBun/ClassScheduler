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
    
    
               
    struct Column: Identifiable {
        var id: String { type.id }
        
        let type: ColumnType
        var areas: [ColumnArea]
    }
    
    struct ColumnArea: Identifiable {
        var id: String { type.id }
        
        let type: ColumnAreaType
        var items: [Block]
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
    
    enum ColumnType: Identifiable {
        case week(_ week: Weeks)
        
        var id: String {
            switch self {
            case .week(let week):
                return "week-\(week.rawValue)"
            }
        }
    }
}

extension LessonList {
    static let mock: LessonList = .init(columns: Weeks.allCases.map({ week in
        Column(type: .week(week), areas: TimeRanges.allCases.map({ timeRange in
            ColumnArea(type: .timeRange(timeRange), items: [AppointmentBlock(id: UUID.init().uuidString, appointment: .init(week: week, timeRange: timeRange, student: .mock))])            
        }))
    }))
}

protocol Block: Codable {
    var id: String { get }
}

enum Weeks: Int, Codable, CaseIterable {
    case monday = 0
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

enum TimeRanges: Int, Codable, CaseIterable {
    case one = 0
    case two
    case three
    case four
}

