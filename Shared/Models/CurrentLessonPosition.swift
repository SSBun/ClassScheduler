//
//  CurrentLessonPosition.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/10.
//

import Foundation
import WCDBSwift

// MARK: - CurrentLessonPosition
struct CurrentLessonPosition: Codable {
    var trackName: String
    var pointName: String

    enum CodingKeys: String, CodingKey {
        case trackName = "track_name"
        case pointName = "point_name"
    }
}

extension CurrentLessonPosition: ColumnCodable {
    init?(with value: FundamentalValue) {
        guard let value = try? CurrentLessonPosition.unpack(value.dataValue) else { return nil }
        self = value
    }
    
    func archivedValue() -> FundamentalValue {
        .init(try! self.pack())
    }
    
    static var columnType: ColumnType {
        .BLOB
    }
    
    
}
