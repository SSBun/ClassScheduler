//
//  LessonAppointment.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation

struct LessonAppointment: Codable {
    let week: Weeks
    let timeRange: TimeRanges
    let student: Student
}
