//
//  CourseCalendar.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/7.
//

import Foundation
import SwiftDate
import WCDBSwift


enum CourseCalendar {
    static var region: Region { Region(calendar: Calendars.republicOfChina, zone: Zones.asiaShanghai, locale: Locales.chinese) }
    static var dateInRegion: DateInRegion { DateInRegion(Date(), region: region) }
            
    static func getWeek(_ index: Int) -> Week {
        let weeks: [WeekDay] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
        
        var days: [Day] = []
        for week in weeks {
            days.append(.init(date: dateInRegion.dateAfter(weeks: index, on: week).dateAt(.tomorrow).dateAt(.startOfDay)))
        }
        return Week(days: days)
    }
}

extension CourseCalendar {
    struct Week: Codable {
        var currentWeek: Bool { !days.filter(\.today).isEmpty }
        let days: [Day]
    }
    
    struct Day: Codable {
        var today: Bool { date.isToday }
        
        let date: DateInRegion
    }
}

extension CourseCalendar.Day: ColumnCodable, ExpressionConvertible {
    func asExpression() -> Expression {
        .init(floatLiteral: date.timeIntervalSince1970)
    }
    
    init?(with value: FundamentalValue) {
        let region = DateInRegion(seconds: value.doubleValue, region: CourseCalendar.region)
        self = Self(date: region)
    }
    
    func archivedValue() -> FundamentalValue {
        FundamentalValue(date.timeIntervalSince1970)
    }
    
    static var columnType: ColumnType {
        .float
    }
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
    
    /// Return the beginning time with format (Hour, Minute)
    var beginningTime: (Int, Int) {
        switch self {
        case .one:
            return (9, 0)
        case .two:
            return (11, 0)
        case .three:
            return (14, 0)
        case .four:
            return (17, 30)
        case .five:
            return (19, 30)
        }
    }
}

extension TimeRanges: ColumnCodable, ExpressionConvertible {
    func asExpression() -> Expression {
        Expression(integerLiteral: self.rawValue)
    }
    
    init?(with value: FundamentalValue) {
        self = Self(rawValue: Int(value.int32Value)) ?? .one
    }
    
    func archivedValue() -> FundamentalValue {
        FundamentalValue(rawValue)
    }
    
    static var columnType: ColumnType {
        .integer32
    }
}
