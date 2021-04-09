//
//  Student.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import WCDBSwift

struct Student: Codable, Identifiable {
    var id: Int
    let name: String
    
    static let mock: Student = .init(id: 1, name: "Student-1")
}

extension Student: DragDropAvailable {
    static let dataIdentifier: String = "Student"
        
}

extension Student: DBTable {
    static let tableName = "t_student"
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Student
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case id = "id"
        case name = "name"
        
        static var columnConstraintBindings: [Student.CodingKeys : ColumnConstraintBinding]? {
            return [id: .init(isPrimary: true, onConflict: .replace),
                    name: .init(isNotNull: true)]
        }
    }
}
