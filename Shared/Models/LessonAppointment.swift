//
//  LessonAppointment.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import WCDBSwift
import SwiftDate

struct LessonAppointment: Codable, Identifiable {
    var id: Int
    var day: CourseCalendar.Day
    var timeRange: TimeRanges
    var studentId: String
    var state: State = .normal
    var info: Info?
    
    var isAutoIncrement: Bool { true }
}

extension LessonAppointment {
    struct Info: Codable {
        var subject: CourseSubject
        var track: CourseTrack
        var point: CoursePoint
        var time: Int?
        var teacher: Teacher?
    }
}

extension LessonAppointment {
    enum State: Int, Codable {
        case normal
        case locked
    }
    
    var openningTime: DateInRegion {
        let date = day.date
        return DateInRegion(year: date.year,
                            month: date.month,
                            day: date.day,
                            hour: timeRange.beginningTime.0,
                            minute: timeRange.beginningTime.1,
                            second: 0,
                            nanosecond: 0,
                            region: CourseCalendar.region)
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

extension LessonAppointment.Info: ColumnCodable {
    init?(with value: FundamentalValue) {
        guard let result = try? LessonAppointment.Info.unpack(value.dataValue) else { return nil }
        self = result
    }
    
    func archivedValue() -> FundamentalValue {
        .init(try! self.pack())
    }
    
    static var columnType: ColumnType {
        .BLOB
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
        case info = "info"
        
        static var columnConstraintBindings: [LessonAppointment.CodingKeys : ColumnConstraintBinding]? {
            return [id: .init(isPrimary: true, isAutoIncrement: true)]
        }
    }
}
