//
//  LessonListView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct LessonListView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack(spacing: 0) {
            NavbarView()
            HSplitView {
                StudentSelector()
                GeometryReader { windowFrame in
                    ScrollView([.horizontal, .vertical], showsIndicators: false) {
                        HStack {
                            ForEach(store.appState.lessonList.columns) { column in
                                VStack {
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
                .background(Color("background"))
            }
        }
    }
}

struct LessonListView_Previews: PreviewProvider {
    static var previews: some View {
        LessonListView()
    }
}
