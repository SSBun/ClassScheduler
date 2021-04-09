//
//  StudentSelector.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct StudentSelector: View {
    @EnvironmentObject var store: Store
    let canDrag: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 20) {
                ForEach(store.appState.studentList.students) { student in
                    Cell(student: student, canDrag: canDrag)
                }
            }
        }
        .frame(minWidth: 150, maxWidth: 150, maxHeight: .infinity, alignment: .top)
        .background(Color.black.opacity(0.2))
    }
}

extension StudentSelector {
    struct Cell: View {
        let student: Student
        let canDrag: Bool
        
        @State private var message: Student? = nil
        
        var body: some View {
            if canDrag {
                content
                .onDrag({ DragDropData(student).itemProvider })
            } else {
                content
            }
        }
        
        @ViewBuilder
        var content: some View {
            Text(student.name)
                .font(.headline)
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(Color.orange)
                .onTapGesture {
                    message = student
                }
                .sheet(item: $message) { msg in
                    VStack {
                        Text("A big title")
                            .font(.largeTitle)
                        Button {
                            withAnimation {
                                message = nil
                            }
                        } label: {
                            Text("close")
                        }
                    }
                    .frame(minWidth: 400, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity, alignment: .center)
                }
        }
    }
}

struct StudentSelector_Previews: PreviewProvider {
    static var previews: some View {
        StudentSelector(canDrag: false)
    }
}