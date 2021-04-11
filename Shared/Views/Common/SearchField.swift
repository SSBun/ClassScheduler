//
//  SearchField.swift
//  ClassScheduler (macOS)
//
//  Created by SSBun on 2021/4/9.
//

import SwiftUI
import SnapKit

struct SearchField: NSViewRepresentable {
    @Binding var content: String
    var placeholderString: String? = nil
    var backgroundColor: NSColor?
    
    let font: NSFont = .systemFont(ofSize: 14)
    
    typealias NSViewType = NSView
    
    func makeNSView(context: NSViewRepresentableContext<SearchField>) -> NSView {
        let view = NSView()
        let searchField = NSSearchField()
        searchField.placeholderString = placeholderString
        searchField.bezelStyle = .squareBezel
        searchField.isBordered = false
        searchField.focusRingType = .none
        searchField.delegate = context.coordinator
        searchField.font = font
        searchField.backgroundColor = backgroundColor ?? NSColor(named: "sidebar_bg")!
        view.addSubview(searchField)
        searchField.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        (nsView.subviews.first as! NSTextField).stringValue = content
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator()
        coordinator.textDidChanged = {
            self.content = $0
        }
        return coordinator
    }
    
}

extension SearchField {
    class Coordinator: NSObject, NSSearchFieldDelegate {
        var textDidChanged: ((String) -> Void)?
                      
        func controlTextDidChange(_ obj: Notification) {
            if let textField = obj.object as? NSSearchField {
                textDidChanged?(textField.stringValue)
            }
        }
    }
}
