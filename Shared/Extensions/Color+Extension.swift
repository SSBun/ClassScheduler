//
//  Color+Extension.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/6.
//

import SwiftUI

extension Color: CSExtensionCompatible {}

extension CSExtension where Base == Color {
    var nsColor: NSColor? {
        if let cgColor = base.cgColor, let color = NSColor(cgColor: cgColor) {
            return color
        }
        return nil
    }
}

extension CSExtension where Base == NSColor {
    var color: Color {
        Color(base.cgColor)
    }
}
