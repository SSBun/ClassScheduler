//
//  NavbarView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct NavbarView: View {
    @EnvironmentObject var store: Store
    
    @State var isSidebarHidden: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                store.dispatch(.toggleSidebar(nil))
            } label: {
                Image(systemName:"sidebar.left")
            }
            .font(.title)
            .buttonStyle(PlainButtonStyle())
            .frame(width: 50, height: 30)
            .padding(.leading, isSidebarHidden ? 110 : 10)
            .padding(.trailing, 10)
            Text("Code Cat")
                .font(.system(size: 30, weight: .black, design: .rounded))
                .shadow(color: Color.black, radius: 3, x: 0, y: 0)
                .padding(.leading, 20)
            Spacer()
            switch store.appState.sidebar.sidebarSelection {
            case .lessonList:
                ZStack {
                    WeekSwitcher()
                    RemoveAreaView().offset(x: 300, y: 0)
                }
            case .studentList, .courseEvaluation:
                Text(store.appState.sidebar.sidebarSelection.info.0)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
            }
            Spacer()
            Button {
                store.dispatch(.toggleLessonListSidebar(nil))
            } label: {
                Image(systemName:"sidebar.right")
            }
            .font(.title)
            .buttonStyle(PlainButtonStyle())
            .frame(width: 50, height: 30)
            .padding(.trailing, 10)
            .isHidden(store.appState.sidebar.sidebarSelection != .lessonList, remove: false)
        }
        .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
        .background(Color("topbar_bg"))
        .onReceive(store.$appState.map(\.sidebar.isHidden)) { value in
            withAnimation {
                isSidebarHidden = value
            }
        }
    }
}

extension NavbarView {
    struct RemoveAreaView: View {
        @EnvironmentObject var store: Store
        @State private var isEntered = false
        
        var body: some View {
            Text("拖动到此处删除")
                .font(.system(size: 20, weight: .black))
                .foregroundColor(isEntered ? Color.white.opacity(0.6) : Color.black.opacity(0.6))
                .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 0, y: 1)
                .frame(width: 180, height: 35, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .stroke(isEntered ? Color.white.opacity(0.6) : Color.black.opacity(0.6), style: StrokeStyle(lineWidth: 2, dash: [5])))
                .onDrop(DropDelegator<AppointmentBlock>(isEntered: $isEntered, receiptData: { block in
                    store.dispatch(.moveBlock(block.id, "blackhole"))
                }))
        }
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}
