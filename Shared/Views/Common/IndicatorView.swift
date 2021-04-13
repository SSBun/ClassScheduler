//
//  IndicatorView.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/13.
//

import SwiftUI

struct IndicatorView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSProgressIndicator {
        let view = NSProgressIndicator()
        view.startAnimation(nil)
        view.style = .spinning
        return view
    }
    
    func updateNSView(_ nsView: NSProgressIndicator, context: Context) {
        
    }
}
