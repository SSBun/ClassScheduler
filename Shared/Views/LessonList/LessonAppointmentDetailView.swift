//
//  LessonAppointmentDetailView.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/12.
//

import SwiftUI

struct LessonAppointmentDetailView: View {
    @EnvironmentObject var store: Store
    
    private var detailInfo: LessonList.AppointmentDetail { store.appState.lessonList.appointmentDetail }
    
    private var infos: [(String, String?)] {
        [("姓名", "ssbun"),
        ("课程", "AAAfsfdsfsdfsdfsdfsdfA课程"),
        ("课节", "aaaaa课节"),
        ("时间", "2021-03-23 周日"),
        ("老师", "大象在天上飞")]
    }
    
    var body: some View {
        ScrollView(.vertical) {
            if let appointment = store.appState.appointmentsData[detailInfo.appointment ?? -1] {
                VStack(alignment: .leading) {
                    Text("预约信息")
                        .foregroundColor(Color.white.opacity(0.5))
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                    ForEach(infos, id: \.0) { info in
                        InfoCell(title: info.0, value: info.1)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .padding(.horizontal, 10)
                    }
                    Button {
                        if appointment.state == .normal {
                            store.dispatch(.requestAppointment(appointment.id))
                        } else {
                            store.dispatch(.cancelAppointment(appointment.id))
                        }
                    } label: {
                        Group {
                            if detailInfo.isRequesting {
                                IndicatorView()
                            } else {
                                if appointment.state == .normal {
                                    Text("预约课程")
                                } else {
                                    Text("取消预约")
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                        .background(appointment.state == .normal ? Color.blue.opacity(0.8) : Color.red.opacity(0.8))
                        .cornerRadius(10)
                    }
                    .disabled(detailInfo.isRequesting)
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 10)
                    .padding(.top, 30)
                }
            }
        }
        .frame(minWidth: 250, maxWidth: 250, maxHeight: .infinity)
        .background(Color("student_list_bg"))
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: -2, y: 2)
        .alert(item: $store.appState.lessonList.appointmentDetail.requestedResult) { result in
            switch result {
            case .success(let title):
                return Alert(title: Text(title))
            case .failure(let error):
                return Alert(title: Text(error.title))
            }
        }
    }
}

extension LessonAppointmentDetailView {
    struct InfoCell: View {
        let title: String
        let value: String?
        
        var body: some View {
            HStack(alignment: .top) {
                Text("\(title): ")
                    .font(.system(size: 15, weight: .bold, design: .default))
                    .foregroundColor(Color.white.opacity(0.5))
                Text(value ?? "null")
                    .font(.system(size: 16, weight: .heavy, design: .default))
                    .lineLimit(3)
                    .foregroundColor(Color.white.opacity(0.8))
                Spacer()
            }
        }
    }
}


extension Result: Identifiable where Success == String, Failure: Error {
    public var id: String {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            return error.localizedDescription
        }
    }
}
