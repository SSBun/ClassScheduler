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
            Text("fjlksjfklads")
                .font(.largeTitle)
        }
        .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
        .background(Color("topbar_bg"))
        .disabled(true)
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}
