//
//  LessonAppointment.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import WCDBSwift

struct LessonAppointment: Codable, Identifiable {
    var id: Int
    var day: CourseCalendar.Day
    var timeRange: TimeRanges
    var studentId: String
    var state: State = .normal
    
    var isAutoIncrement: Bool { true }
}

extension LessonAppointment {
    enum State: Int, Codable {
        case normal
        case locked
    }
}

extension LessonAppointment.State: ColumnCodable {
    init?(with value: FundamentalValue) {
        self = LessonAppointment.State(rawValue: Int(value.int32Value)) ?? .normal
    }
    
    func archivedValue() -> FundamentalValue {
        .init(self.rawValue)
    }
    
    static var columnType: ColumnType {
        .integer32
    }
}

extension LessonAppointment: DBTable {
    static let tableName = "t_lesson_appointment"
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = LessonAppointment
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case id = "id"
        case day = "day"
        case timeRange = "timeRange"
        case studentId = "studentId"
        case state = "state"
        
        static var columnConstraintBindings: [LessonAppointment.CodingKeys : ColumnConstraintBinding]? {
            return [id: .init(isPrimary: true, isAutoIncrement: true)]
        }
    }
}
