//
//  SidebarView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var store: Store
    
    @Namespace var ns
    @State private var sidebarSelectionitem: AppState.SidebarItem = .lessonList
    
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
                .foregroundColor(sidebarSelectionitem == item ? Color("tabbar_selected") : Color("tabbar_normal"))
                .matchedGeometryEffect(id: item.id, in: ns)
                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)

            }
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(Color("tabbar_selected_bg")).matchedGeometryEffect(id: sidebarSelectionitem.id, in: ns, isSource: false))
        .padding(.top, 120)
        .frame(minWidth: 100, maxWidth: 100, maxHeight: .infinity, alignment: .top)
        .background(Color("sidebar_bg"))
        .onReceive(store.$appState.map(\.sidebar.sidebarSelection)) { item in
            withAnimation {
                sidebarSelectionitem = item
            }
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView().environmentObject(Store())
    }
}
