//
//  NiblessView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/10.
//

import AppKit

class NiblessView: NSView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    @available(macOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
