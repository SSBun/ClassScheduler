//
//  StaticTextView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/17.
//

import AppKit

class StaticTextField: NSTextField {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
      }

      required init?(coder: NSCoder) {
        super.init(coder: coder)
      }

      override func hitTest(_ point: NSPoint) -> NSView? {
        return nil
      }
}
