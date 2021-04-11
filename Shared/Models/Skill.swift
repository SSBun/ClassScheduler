//
//  Skill.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/10.
//

import Foundation
import WCDBSwift

// MARK: - Skill
struct Skill: Codable {
    var intent: Int
    var studyPurpose: Int
    var computerFoundation: Int
    var operatingSystem: Int
    var programFoundation: Int
    var preferredTeacherType: Int
    var hobby: Int
    var parentsKnowProgram: Int

    enum CodingKeys: String, CodingKey {
        case intent = "intent"
        case studyPurpose = "study_purpose"
        case computerFoundation = "computer_foundation"
        case operatingSystem = "operating_system"
        case programFoundation = "program_foundation"
        case preferredTeacherType = "preferred_teacher_type"
        case hobby = "hobby"
        case parentsKnowProgram = "parents_know_program"
    }
}

extension Skill: ColumnCodable {
    init?(with value: FundamentalValue) {
        guard let value = try? Skill.unpack(value.dataValue) else { return nil }
        self = value
    }
    
    func archivedValue() -> FundamentalValue {
        .init(try! self.pack())
    }
    
    static var columnType: ColumnType {
        .BLOB
    }    
}
