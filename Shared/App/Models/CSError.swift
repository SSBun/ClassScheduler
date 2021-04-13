//
//  CSError.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/13.
//

import Foundation


struct CSError: Error, Identifiable, ExpressibleByStringInterpolation {
    let id = UUID()
    var title: String
    var content: String?
    var wrapped: Error?
    
    init(stringLiteral value: String) {
        self.title = value
    }
}
