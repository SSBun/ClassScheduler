//
//  Student.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation

struct Student: Codable {
    let name: String
    
    static let mock: Student = .init(name: "Leta Pfeffer")
}
