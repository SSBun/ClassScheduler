//
//  NavbarView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct NavbarView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.orange.opacity(0.2))
        }.frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}
