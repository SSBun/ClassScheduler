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
    @State var isEntered: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(isEntered ? Color.red.opacity(0.5) : Color.gray.opacity(0))
            VStack {
                ForEach(area.items, id: \.id) { block in
                    if block is AppointmentBlock {
                        AppointmentBlockView(block: block as! AppointmentBlock)
                    }
                }
            }
            .padding(.vertical, 5)
        }
        .background(Color.blue.opacity(0.1))
        .frame(minWidth: 150, minHeight: 150)
        .onDrop(of: DragDropData<AppointmentBlock>.readableTypeIdentifiersForItemProvider,
                delegate: DropDelegator<AppointmentBlock>(isEnabled: area.items.count < 4, isEntered: $isEntered, receiptData: { block in
                    DispatchQueue.main.async {
                        store.dispatch(.move(block.id, area.id))                        
                    }
        }))
    }
}

struct AreaView_Previews: PreviewProvider {
    static var previews: some View {
        AreaView(area: .init(type: .timeRange(.four), items: []))
    }
}
