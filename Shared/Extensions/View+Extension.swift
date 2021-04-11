//
//  View+Extension.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/11.
//

import SwiftUI

extension View {
    @ViewBuilder
    func isHidden(_ hidden: Bool, remove: Bool) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
