//
//  UserTag.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/10.
//

import Foundation
import WCDBSwift

// MARK: - UserTag
struct UserTag: Codable {
    var id: String
    var name: String
    var userId: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case userId = "user_id"
    }
}

extension UserTag: ColumnCodable {
    init?(with value: FundamentalValue) {
        guard let value = try? UserTag.unpack(value.dataValue) else { return nil }
        self = value
    }
    
    func archivedValue() -> FundamentalValue {
        .init(try! self.pack())
    }
    
    static var columnType: ColumnType {
        .BLOB
    }
}
