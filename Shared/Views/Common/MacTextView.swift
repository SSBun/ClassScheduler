//
//  MacTextView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/10.
//

import SwiftUI

struct MacTextView: NSViewRepresentable {
    typealias NSViewType = ContentView
    @Binding var text: String
    var font: NSFont?
    var backgroundColor: NSColor?
    var placeholder: String?
    
    func makeNSView(context: Context) -> ContentView {
        let view = ContentView()
        view.textDidChanged = {
            text = $0
        }
        return view
    }
    
    func updateNSView(_ nsView: ContentView, context: Context) {
        if nsView.text != text {
            nsView.text = text
        }
        nsView.placeholder = placeholder
        nsView.font = font
        nsView.backgroundColor = backgroundColor
    }
}

extension MacTextView {
    class ContentView: NiblessView, NSTextViewDelegate {
        var text: String {
            set {
                textView.string = newValue
            }
            get {
                textView.string
            }
        }
        var textDidChanged: ((String) -> Void)?
        var placeholder: String? { didSet { refreshConfig() } }
        
        let textView = NSTextView()
        let placeholderLabel = StaticTextField()
        var font: NSFont? { didSet { refreshConfig() } }
        var backgroundColor: NSColor? { didSet { refreshConfig() }}
        
        override init(frame frameRect: NSRect) {
            super.init(frame: frameRect)
            setupUI()
        }
        
        private func refreshConfig() {
            let newFont = font ?? .systemFont(ofSize: 16)
            textView.font = newFont
            placeholderLabel.font = newFont
            textView.backgroundColor = backgroundColor ?? .clear
            placeholderLabel.stringValue = placeholder ?? ""
        }
                        
        private func setupUI() {
            let scrollView = NSScrollView()
            scrollView.hasVerticalScroller = true
            scrollView.documentView = textView
            scrollView.backgroundColor = .clear
            addSubview(scrollView)
            scrollView.snp.makeConstraints {
                $0.edges.equalTo(self)
            }
            
            textView.delegate = self
            placeholderLabel.backgroundColor = .clear
            placeholderLabel.maximumNumberOfLines = 0
            placeholderLabel.isBordered = false
            placeholderLabel.alphaValue = 0.4
            addSubview(placeholderLabel)
            placeholderLabel.snp.makeConstraints {
                $0.leading.top.trailing.equalTo(self)
            }
        }
        
        override func layout() {
            super.layout()
            textView.frame = bounds
        }
        
        func textDidChange(_ notification: Notification) {
            if notification.object as! NSObject == textView {
                textDidChanged?(textView.string)
                placeholderLabel.isHidden = textView.string.count > 0
            }
        }
    }
}
