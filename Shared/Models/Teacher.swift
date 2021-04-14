//
//  Teacher.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/12.
//

import Foundation
import WCDBSwift

struct Teacher: Codable {
    var name: String
    var id: String
    var token: String?
}

extension Teacher {
    static var mock: Teacher {
        Teacher(name: "小羊老师", id: "5106", token: "__ca_uid_key__=19e2a42c-0cc3-48e4-a757-9288950e4680; internal_account_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJUb2tlbiIsImF1dGgiOiJST0xFX0FETUlOIiwibmFtZSI6IuadqOmUkCIsImVuaWQiOjE2MjUyLCJpYXQiOjE2MTc3MjE4MTEsImp0aSI6IjQyZjkxZmYzLWFhMmEtNGMyNi1iOWE0LWM5ZWM5MmQzMjgzOSJ9.IDpXnYdEsk_ISGwNbL7-OWvYqdg8-tAYH_nGN7nVLYQ; admin-authorization=Bearer+eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX3R5cGUiOiJhZG1pbiIsInVzZXJfaWQiOjE0NzI2LCJpYXQiOjE2MTc2OTMwMTEsImp0aSI6IjJlODZlY2IzLTk2ZWEtMTFlYi04ZGQ4LTdiMzQwMjgwNDZlYSJ9.HbUNjsX5PACj8pHIBwV0ifK2S-AdkWuCdcCg4LvKOgs; Hm_lvt_1d120ad5df69bc82535c08f98ad2c1e7=1618060826; _ga=GA1.2.255638837.1618060827; SERVERID=7eadfc7a9d5ed6727c515ba9042221d8|1618238168|1618235798")
    }
}
