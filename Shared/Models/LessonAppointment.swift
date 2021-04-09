//
//  LessonAppointment.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation

struct LessonAppointment: Codable, Identifiable {
    var id: String = UUID().uuidString
    let day: CourseCalendar.Day
    let timeRange: TimeRanges
    let studentId: Int
}

