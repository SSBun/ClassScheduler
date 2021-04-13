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
    var topOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            SearchBar()
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 10) {
                    ForEach(store.appState.studentList.searchedStudents, id: \.self) { studentId in
                        Cell(studentId: studentId, canDrag: canDrag)
                            .padding(.horizontal, 4)
                    }
                }
            }
            BottomBar()
                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
        }
        .padding(.top, topOffset)
        .frame(minWidth: 200, maxWidth: 200, maxHeight: .infinity, alignment: .top)
        .background(Color("student_list_bg"))
    }
}

extension StudentSelector {
    struct SearchBar: View {
        @EnvironmentObject var store: Store
        
        var body: some View {
            SearchField(content: $store.appState.studentList.search.content, placeholderString: "查找学生", backgroundColor: NSColor(named: "search_bg"))
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2)))
                .background(RoundedRectangle(cornerRadius: 8)
                                .fill(Color("search_bg")))
                .padding(5)
        }
    }
    
    struct BottomBar: View {
        @State private var isPresented = false
        
        var body: some View {
            HStack {
                Button {
                    isPresented.toggle()
                } label: {
                    Label("添加学生", systemImage: "plus.rectangle.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("search_bg"))
                }
                .buttonStyle(PlainButtonStyle())
            }
            .sheet(isPresented: $isPresented) {
                ImportStudentView(isPresented: $isPresented)
            }
        }
    }
}

extension StudentSelector {
    struct Cell: View {
        enum Action: Int, Identifiable {
            case requestInfo
            case remove
            
            var id: Int { self.rawValue }
        }
        
        @EnvironmentObject var store: Store
        let studentId: String
        let canDrag: Bool
        @State private var alertMessage: Action? = nil
        
        private var student: Student? { store.appState.studentList.studentsData[studentId] }
        
        var body: some View {
            if canDrag, let student = student {
                content
                .onDrag({ DragDropData(student).itemProvider })
            } else {
                content
            }
        }
        
        @ViewBuilder
        var content: some View {
            VStack {
                HStack {
                    Text("ID: \(studentId)")
                        .font(.system(size: 12, weight: .light, design: .rounded))
                        .padding(.horizontal, 3)
                        .background(Color("student_block_id_bg"))
                        .cornerRadius(3)
                    Spacer()
                    Button {
                        self.alertMessage = .remove
                    } label: {
                        Image(systemName: "trash.circle.fill")
                            .foregroundColor(Color.red.opacity(0.8))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding([.top, .trailing], 5)
                    Button {
                        self.alertMessage = .requestInfo
                    } label: {
                        Image(systemName: "info.circle.fill")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding([.top, .trailing], 5)
                }
                Text("\(student?.nickName ?? "暂无信息")")
                    .font(.system(size: 15, weight: .medium, design: .monospaced))
                    .frame(maxWidth: .infinity, minHeight: 40)
            }
            .background(Color("student_block_bg_noinfo"))
            .cornerRadius(6)
            .onTapGesture {
                store.dispatch(.selectStudent(studentId))
            }
            .alert(item: $alertMessage) { message in
                let title = message == .remove
                    ? "删除学生\(student?.fullName ?? "\(studentId)")信息"
                    : " 更新学生\(student?.fullName ?? "\(studentId)")信息"
                
                return Alert(title: Text(title),
                      primaryButton: .default(Text("确定"), action: {
                        if message == .remove {
                            store.dispatch(.removeStudent(studentId))
                        } else {
                            store.dispatch(.requestStudentInfo(studentId))
                        }
                      }),
                      secondaryButton: .cancel(Text("取消")))
            }
        }
    }
}


struct StudentSelector_Previews: PreviewProvider {
    static var previews: some View {
        StudentSelector(canDrag: false)
            .environmentObject(Store())
    }
}
