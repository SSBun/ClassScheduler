//
//  StudentDetailView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI
import WCDBSwift

struct StudentDetailView: View {
    @EnvironmentObject var store: Store
    private var student: Student? { store.appState.studentList.studentsData[store.appState.studentList.currentStudent ?? ""] }
    private var infos: [InfoRow] { generateInfos() }
    
    var body: some View {
        VStack {
            if student != nil {
                VStack(spacing: 10) {
                    ForEach(infos, id: \.title) { infoRow in
                        generateInfoCell(infoRow)
                    }
                    Spacer()
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
    private func generateInfoCell(_ infoRow: InfoRow) -> some View {
        switch infoRow.value {
        case .string(let string):
            HStack(alignment: .top) {
                Text("\(infoRow.title): ")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .frame(minWidth: 40)
                Text(string ?? "")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .padding(.leading, 10)
                    .lineLimit(3)
                Spacer()
            }
            .padding(.leading, 10)
        case .group(_):
            HStack {
                Text("\(infoRow.title): ")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color.gray.opacity(0.9))
                Spacer()
            }
            .padding(.bottom, 10)
        }
    }
    
    private func generateInfos() -> [InfoRow] {
        if let student = student {
            return InfoRow.makeInfoRows {
                InfoRow(title: "个人信息") {
                    InfoRow(title: "昵称", value: .string(student.nickName))
                    InfoRow(title: "全名", value: .string(student.fullName))
                    InfoRow(title: "ID", value: .string(student.id))
                    InfoRow(title: "性别", value: .string(student.sex == 1 ? "男" : "女"))
                    InfoRow(title: "城市", value: .string(student.cityName))
                    InfoRow(title: "省份", value: .string(student.provinceName))
                    InfoRow(title: "年龄", value: .string(student.age?.description))
                    InfoRow(title: "生日", value: .string(student.birthday?.description))
                    InfoRow(title: "年纪", value: .string(student.grade?.description))
                    InfoRow(title: "Email", value: .string(student.email))
                    InfoRow(title: "channelSourceName", value: .string(student.channelSourceName))
                    InfoRow(title: "channelName", value: .string(student.channelName))
                    InfoRow(title: "channelId", value: .string(student.channelId?.description))
                    InfoRow(title: "channelSourceId", value: .string(student.channelSourceId?.description))
                    InfoRow(title: "schoolName", value: .string(student.schoolName))
                    InfoRow(title: "parentsInfo", value: .string(student.parentsInfo.debugDescription))
                }
            }.flatMap { $0.flat() }
        } else {
            return []
        }
    }
}

struct StudentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StudentDetailView()
    }
}

// MARK: - InfoRow is a Form Structure
struct InfoRow {
    var title: String
    var value: Value
    
    init(title: String, value: Value) {
        self.title = title
        self.value = value
    }
    
    init(title: String, @InfoRowBuilder builder: () -> [InfoRow]) {
        self.title = title
        self.value = .group(builder())
    }
    
    func flat() -> [InfoRow] {
        var result: [InfoRow] = []
        result += [self]
        if case let .group(infoRows) = self.value {
            infoRows.forEach { infoRow in
                result += infoRow.flat()
            }
        }
        return result
    }
}

extension InfoRow {
    enum Value {
        case string(String?)
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
