//
//  CourseCalendar.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/7.
//

import Foundation
import SwiftDate


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
