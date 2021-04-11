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
                } label: {
                    Image(systemName: item.info.1)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(10)
                .foregroundColor(store.appState.sidebar.sidebarSelection == item ? Color("tabbar_selected") : Color("tabbar_normal"))
                .background(store.appState.sidebar.sidebarSelection == item ? Color("tabbar_selected_bg") : Color.clear)
                .cornerRadius(10)
                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            }
        }
        .padding(.top, 120)
        .frame(minWidth: 100, maxWidth: 100, maxHeight: .infinity, alignment: .top)
        .background(Color("sidebar_bg"))
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView().environmentObject(Store())
    }
}
