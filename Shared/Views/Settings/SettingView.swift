//
//  SettingView.swift
//  ClassScheduler (macOS)
//
//  Created by SSBun on 2021/5/28.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var store: Store
    
    private var repeatTimesOfInsertingAnAppointment: Int { store.appState.settings.repeatTimesOfInsertingAnAppointment }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("同样时间段,在多周插入预约")
                Spacer()
                Stepper("同时在\(repeatTimesOfInsertingAnAppointment)周插入") {
                    store.dispatch(.updateRepeatTimesOfInsertingAnAppointment(repeatTimesOfInsertingAnAppointment+1))
                } onDecrement: {
                    store.dispatch(.updateRepeatTimesOfInsertingAnAppointment(repeatTimesOfInsertingAnAppointment-1))
                }
            }
            Spacer()
            Button(action: {
                store.dispatch(.toggleSettingsView(false))
            }, label: {
                Text("关闭")
                    .font(.system(size: 16))
            })
            .frame(width: 100, height: 30)
            .background(Color.red)
            .cornerRadius(15)
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal,  80)
        .padding(.vertical, 20)
        .frame(width: 500, height: 500, alignment: .top)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(Store())
    }
}
