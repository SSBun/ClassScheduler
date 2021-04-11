//
//  ParentsInfo.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/10.
//

import Foundation
import WCDBSwift

// MARK: - ParentsInfo
struct ParentsInfo: Codable {
    var backupPhoneNumber: String
    var parentsJob: Int

    enum CodingKeys: String, CodingKey {
        case backupPhoneNumber = "backup_phone_number"
        case parentsJob = "parents_job"
    }
}

extension ParentsInfo: ColumnCodable {
    init?(with value: FundamentalValue) {
        guard let value = try? ParentsInfo.unpack(value.dataValue) else { return nil }
        self = value
    }
    
    func archivedValue() -> FundamentalValue {
        FundamentalValue(try! self.pack())
    }
    
    static var columnType: ColumnType {
        .BLOB
    }
}
