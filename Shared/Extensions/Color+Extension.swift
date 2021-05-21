//
//  Color+Extension.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/6.
//

import SwiftUI

extension Color: CSExtensionCompatible {}

#if os(macOS)
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
#elseif os(iOS)
#endif
