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
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 20) {
                ForEach(store.appState.studentList.students) { student in
                    Text(student.name)
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.orange)
                }
            }
        }
        .frame(minWidth: 150, maxWidth: 150, maxHeight: .infinity, alignment: .top)
        .background(Color.black.opacity(0.2))
    }
}

struct StudentSelector_Previews: PreviewProvider {
    static var previews: some View {
        StudentSelector()
    }
}
