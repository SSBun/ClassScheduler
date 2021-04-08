//
//  Codable+Extension.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation

extension Decodable {
    static func unpack(_ data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}

extension Encodable {
    func pack() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
