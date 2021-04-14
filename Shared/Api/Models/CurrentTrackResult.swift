//
//  CurrentTrackResult.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/14.
//

import Foundation

// MARK: - CurrentTrackResult
struct CurrentTrackResult: Codable {
    let hasStudentPosition: Bool
    let tracks: [CourseTrack]
    
    enum CodingKeys: String, CodingKey {
        case hasStudentPosition = "has_student_position"
        case tracks
    }
}

// MARK: - Track
struct CourseTrack: Codable {
    let id: Int
    let name: String
    let duration, cost: Int
    let isAvailable: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, duration, cost
        case isAvailable = "is_available"
    }
}
