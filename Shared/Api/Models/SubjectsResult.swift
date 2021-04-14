//
//  SubjectsResult.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/14.
//

import Foundation

// MARK: - SubjectsResult
struct SubjectsResult: Codable {
    let hasStudentPosition: Bool
    let subjects: [CourseSubject]
    
    enum CodingKeys: String, CodingKey {
        case hasStudentPosition = "has_student_position"
        case subjects
    }
}

// MARK: - Subject
struct CourseSubject: Codable {
    let id: Int
    let name: String
    let isAvailable: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case isAvailable = "is_available"
    }
}
