//
//  StudentSelector.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct StudentSelector: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                ForEach(store.appState.studentList.students) { student in
                    Text(student.name)
                        .font(.headline)
                        .frame(minHeight: 40)
                        .background(Color.orange)
                }
            }
        }
        .frame(minWidth: 200, maxWidth: 200, maxHeight: .infinity, alignment: .top)
        .background(Color.black.opacity(0.2))
    }
}

struct StudentSelector_Previews: PreviewProvider {
    static var previews: some View {
        StudentSelector()
    }
}
