//
//  CurrentLessonResult.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/14.
//

import Foundation

// MARK: - CurrentLessonResult
struct CurrentPointResult: Codable {
    let hasStudentPosition: Bool
    let points: [CoursePoint]
    
    enum CodingKeys: String, CodingKey {
        case hasStudentPosition = "has_student_position"
        case points
    }
}

// MARK: - Point
struct CoursePoint: Codable {
    let id: Int
    let name, aliasName: String
    let isOnline: Bool
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case aliasName = "alias_name"
        case isOnline = "is_online"
        case status
    }
}
