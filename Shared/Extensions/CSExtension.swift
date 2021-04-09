//
//  CSExtension.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/8.
//

import Foundation

public struct CSExtension<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol CSExtensionCompatible {
    associatedtype CSExtensionBase
    
    static var cs: CSExtension<CSExtensionBase>.Type { get set }
    var cs: CSExtension<CSExtensionBase> { get set }
}

extension CSExtensionCompatible {
    public static var cs: CSExtension<Self>.Type {
        get { CSExtension<Self>.self }
        set { }
    }
    
    public var cs: CSExtension<Self> {
        get { CSExtension(self) }
        set { }
    }
}
