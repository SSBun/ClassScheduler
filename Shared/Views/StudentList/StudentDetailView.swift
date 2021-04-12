//
//  StudentDetailView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct StudentDetailView: View {
    @EnvironmentObject var store: Store
    private var student: Student? { store.appState.studentList.studentsData[store.appState.studentList.currentStudent ?? ""] }
    
    var body: some View {
        VStack {
            if let student = student {
                HStack {
                    VStack {
                        header("基本信息")
                        infoCell("昵称", student.nickName ?? "null")
                        infoCell("真实姓名", student.nickName ?? "null")
                        infoCell("昵称", student.nickName ?? "null")
                        infoCell("昵称", student.nickName ?? "null")
                        infoCell("昵称", student.nickName ?? "null")
                        infoCell("昵称", student.nickName ?? "null")
                        infoCell("昵称", student.nickName ?? "null")
                        infoCell("昵称", student.nickName ?? "null")
                        Spacer()
                    }
                    VStack {
                        
                    }
                }
                .padding(20)
            } else {
                Text("未选中学生")
                    .font(.system(size: 60, weight: .black))
                    .foregroundColor(Color.black.opacity(0.3))
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func header(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .default))
            Spacer()
        }
        .padding(.bottom, 20)
    }
    
    @ViewBuilder
    private func infoCell(_ title: String, _ content: String) -> some View {
        HStack {
            Text("\(title): ")
                .font(.system(size: 16, weight: .regular, design: .rounded))
            Text(content)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .padding(.leading, 10)
            Spacer()
        }
    }
    
    private func generateInfos() {
        let result =
            InfoRow.makeInfoRows {
                InfoRow(title: "姓名", value: .string("ssbun"))
                InfoRow(title: "昵称", value: .group([]))
            }
    }
}

struct StudentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StudentDetailView()
    }
}

struct InfoRow {
    var title: String
    var value: Value
}

extension InfoRow {
    enum Value {
        case string(String)
        case group([InfoRow])
    }
}

@_functionBuilder
struct InfoRowBuilder {
    static func buildBlock(_ rows: InfoRow...) -> [InfoRow] {
        rows
    }
}

extension InfoRow {
    static func makeInfoRows(@InfoRowBuilder builder: () -> [InfoRow]) -> [InfoRow] {
        builder()
    }
}
