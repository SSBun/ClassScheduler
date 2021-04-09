//
//  DatabaseExtension.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/9.
//

import Foundation

public struct DBExtension<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol DBExtensionCompatible {
    associatedtype DBExtensionBase
    
    static var db: DBExtension<DBExtensionBase>.Type { get set }
    var db: DBExtension<DBExtensionBase> { get set }
}

extension DBExtensionCompatible {
    public static var db: DBExtension<Self>.Type {
        get { DBExtension<Self>.self }
        set { }
    }
    
    public var db: DBExtension<Self> {
        get { DBExtension(self) }
        set { }
    }
}
