//
//  NavbarView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct NavbarView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        HStack(spacing: 0) {
            Text("Code Cat")
                .font(.largeTitle)
                .padding(.leading, store.appState.sidebar.isHidden ? 80 : 20)
            Spacer()
            Button {
                store.dispatch(.toggleSidebar(nil))
            } label: {
                Image(systemName:"sidebar.left")
            }
            .font(.title)
            .buttonStyle(PlainButtonStyle())
            .frame(width: 50, height: 30)
            .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
        .background(Color("topbar_bg"))
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}
