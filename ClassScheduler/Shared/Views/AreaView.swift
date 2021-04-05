//
//  AreaView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct AreaView: View {
    @EnvironmentObject var store: Store
    var area: LessonList.ColumnArea
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color.gray.opacity(0.5))
            VStack {
                ForEach(area.items, id: \.id) { block in
                    if block is AppointmentBlock {
                        AppointmentBlockView(block: block as! AppointmentBlock)
                    }
                }
            }
        }
        .frame(minWidth: 200, minHeight: 150)
    }
}

struct AreaView_Previews: PreviewProvider {
    static var previews: some View {
        AreaView(area: .init(type: .timeRange(.four), items: []))
    }
}
