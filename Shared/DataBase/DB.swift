//
//  DB.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/8.
//

import Foundation
import WCDBSwift

enum DB {
    static let database = Database(withPath: "./codecat.db")
    static func initialize() throws {
        try database.create(table: "personmodel", of: PersonModel.self)        
    }
}

protocol DBTable: TableCodable, CSExtensionCompatible {
    static var tableName: String { get }
}

extension CSExtension where Base: DBTable {
    
}

struct PersonModel: DBTable {    
    static var tableName: String = "personmodel"
    let id: String
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = PersonModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case id
    }
}
