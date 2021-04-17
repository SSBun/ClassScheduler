//
//  RightClickableView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/17.
//

import SwiftUI
import SnapKit

struct RightClickableView<Content: View>: NSViewRepresentable {
    private let content: Content
    let rightMouseClickHandle: () -> Void

    init(@ViewBuilder content: () -> Content, rightMouseClickHandle: @escaping () -> Void) {
        self.content = content()
        self.rightMouseClickHandle = rightMouseClickHandle
    }

    func makeNSView(context: Context) -> ContainerView {
        let contentView = ContainerView()
        contentView.rightClickHandle =  rightMouseClickHandle
        let hostingView = NSHostingView(rootView: content)
        contentView.addSubview(hostingView)
        hostingView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        return contentView
    }
    
    func updateNSView(_ nsView: ContainerView, context: Context) {
        
    }
}

extension RightClickableView {
    class ContainerView: NSView {
        var rightClickHandle: (() -> Void)?
        var leftClickHandle: (() -> Void)?
                
        override func mouseDown(with event: NSEvent) {
            leftClickHandle?()
        }
        
        override func rightMouseDown(with event: NSEvent) {
            rightClickHandle?()
        }
    }
}
