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
}

protocol DBTable: TableCodable, DBExtensionCompatible {
    static var tableName: String { get }
}

extension DBExtension where Base: DBTable {
    // MARK: - CREATE TABLE
    /// Create a table if not exist.
    static func create() throws {
        do {
            try DB.database.create(table: Base.tableName, of: Base.self)
        } catch(let error) {
            LOG(category: .database, error)
            throw error
        }
    }
    
    static func drop() throws {
        do {
            try DB.database.drop(table: Base.tableName)
        } catch(let error) {
            LOG(category: .database, error)
            throw error
        }
    }
    
    static func checkTable() throws {
        do {
            let isExist = try DB.database.isTableExists(Base.tableName)
            if !isExist {
                try create()
            }
        } catch(let error) {
            LOG(category: .database, error)
            throw error
        }
    }
    
    // MARK:- INSERT
    
    func insert(on propertyConvertibleList: [WCDBSwift.PropertyConvertible]? = nil, replace: Bool = false) throws {
        try Self.checkTable()
        try Self.insert(base, on: propertyConvertibleList, replace: replace)
    }
    
    static func insert(_ objects: Base..., on propertyConvertibleList: [WCDBSwift.PropertyConvertible]? = nil, replace: Bool = false) throws {
        do {
            try Self.checkTable()
            if replace {
                try DB.database.insertOrReplace(objects: objects, on: propertyConvertibleList, intoTable: Base.tableName)
            } else {
                try DB.database.insert(objects: objects, on: propertyConvertibleList, intoTable: Base.tableName)
            }
        } catch(let error) {
            LOG(category: .database, error)
            throw(error)
        }
    }
    
    // MARK: - DELETE
    
    /// Delete data
    /// You can think of this: Sort the data in the `table` that meet the `condition` according to the `orderList`, and then delete the `limit` rows
    /// after the `offset` rows from the beginning.
    static func delete(where condition: Condition? = nil,
                       orderBy orderList: [OrderBy]? = nil,
                       limit: Limit? = nil,
                       offset: Offset? = nil) throws {
        do {
            try Self.checkTable()
            try DB.database.delete(fromTable: Base.tableName,
                                   where: condition,
                                   orderBy: orderList,
                                   limit: limit,
                                   offset: offset)
        } catch(let error) {
            LOG(category: .database, error)
            throw(error)
        }
    }
    
    // MARK: - UPDATE
    /// Update the table using itself properties
    func update(on propertyConvertibleList: [PropertyConvertible],
                where condition: Condition? = nil,
                orderBy orderList: [OrderBy]? = nil,
                limit: Limit? = nil,
                offset: Offset? = nil) throws {
        do {
            try Self.checkTable()
            try DB.database.update(table: Base.tableName, on: propertyConvertibleList,
                                   with: base,
                                   where: condition,
                                   orderBy: orderList,
                                   limit: limit,
                                   offset: offset)
        } catch(let error) {
            LOG(category: .database, error)
            throw(error)
        }
    }
    
    static func update(on propertyConvertibleList: [PropertyConvertible],
                       with row: [ColumnEncodable],
                       where condition: Condition? = nil,
                       orderBy orderList: [OrderBy]? = nil,
                       limit: Limit? = nil,
                       offset: Offset? = nil) throws {
        do {
            try Self.checkTable()
            try DB.database.update(table: Base.tableName,
                                   on: propertyConvertibleList,
                                   with: row,
                                   where: condition,
                                   orderBy: orderList,
                                   limit: limit,
                                   offset: offset)
        } catch(let error) {
            LOG(category: .database, error)
            throw(error)
        }
    }
    
    // MARK: - QUERY
    static func get(on propertyConvertibleList: [PropertyConvertible],
                    where condition: Condition? = nil,
                    orderBy orderList: [OrderBy]? = nil,
                    limit: Limit? = nil,
                    offset: Offset? = nil) throws -> [Base] {
        do {
            try Self.checkTable()
            return try DB.database.getObjects(on: propertyConvertibleList,
                                              fromTable: Base.tableName,
                                              where: condition,
                                              orderBy: orderList,
                                              limit: limit,
                                              offset: offset)
            
        } catch(let error) {
            LOG(category: .database, error)
            throw(error)
        }
    }
}
