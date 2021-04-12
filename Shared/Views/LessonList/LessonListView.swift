//
//  LessonListView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct LessonListView: View {
    @EnvironmentObject var store: Store
    
    @State var isAppointmentDetailViewHidden: Bool = true
    
    private let hSpacing: CGFloat = 5
    private let vSpacing: CGFloat = 5
    private let hTagHeight: CGFloat = 40
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                StudentSelector(canDrag: true, topOffset: 5)
                HStack(spacing: 0) {
                    VStack(spacing: vSpacing) {
                        ForEach(store.appState.lessonList.rowTypes) {
                            VTagView(tagData: $0)
                        }
                    }
                    .padding(.top, hTagHeight)
                    VStack(spacing: 0) {
                        HStack(spacing: hSpacing) {
                            ForEach(store.appState.lessonList.colTypes) {
                                HTagView(tagData: $0)
                                    .frame(maxWidth: .infinity, minHeight: hTagHeight, maxHeight: hTagHeight)
                            }                            
                        }
                        GeometryReader { windowFrame in
                            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                                HStack(spacing: hSpacing) {
                                    ForEach(store.appState.lessonList.columns) { column in
                                        VStack(spacing: vSpacing) {
                                            ForEach(column.areas) { area in
                                                AreaView(area: area)
                                            }
                                        }
                                    }
                                }
                                .frame(minWidth: windowFrame.size.width,
                                       minHeight: windowFrame.size.height)
                            }
                        }
                    }
                }
                .background(Color("background"))
                .zIndex(1)
                LessonAppointmentDetailView()
                    .isHidden(isAppointmentDetailViewHidden, remove: true)
            }
        }
        .onReceive(store.$appState.map(\.lessonList.isSidebarHidden)) { value in
            withAnimation {
                isAppointmentDetailViewHidden = value
            }
        }
    }
}

struct LessonListView_Previews: PreviewProvider {
    static var previews: some View {
        LessonListView()
    }
}
