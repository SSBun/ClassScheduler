//
//  SidebarView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(AppState.SidebarItem.allCases) { item in
                Button {
                    store.dispatch(.switchSidebar(item))
                    store.dispatch(.requestStudentInfo("20"))
                } label: {
                    Label(item.title, systemImage: "applelogo")
                        .padding(.leading, 10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                }
                .buttonStyle(PlainButtonStyle())
                .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 30)
                .background(store.appState.sidebarSelection == item ? Color.gray : Color.clear)
            }
        }
        .padding(.top, 50)
        .frame(minWidth: 100, maxWidth: 200, maxHeight: .infinity, alignment: .top)
        .background(Color("sidebar_bg"))
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
