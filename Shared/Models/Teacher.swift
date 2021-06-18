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
    var id: Int
    var token: String?
}

extension Teacher {
    static var mock: Teacher {
        Teacher(name: "北京杨锐", id: 5106, token: "Hm_lvt_1d120ad5df69bc82535c08f98ad2c1e7=1618060826; _ga=GA1.2.255638837.1618060827; __ca_uid_key__=1ceb9217-74a9-4d5f-9728-02192f01e6e5; TY_SESSION_ID=d21c08c1-540a-4c03-850a-c93576456186; internal_account_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJUb2tlbiIsImF1dGgiOiJST0xFX0FETUlOIiwibmFtZSI6IuadqOmUkCIsImVuaWQiOjE2MjUyLCJpYXQiOjE2MjI0MjUwNDcsImp0aSI6IjkyOWU5NWNhLTJjOTctNDIwMy1iNzI1LTQ0YThlZjQ3YTAyNiJ9.xUkPyN4OllWJMEf5JcrT5hnuUHne-TwYFq5CiCaE8ro; admin-authorization=Bearer+eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX3R5cGUiOiJhZG1pbiIsInVzZXJfaWQiOjE0NzI2LCJpYXQiOjE2MjIzOTYyNDcsImp0aSI6ImMxYjJmZTNlLWMxYjAtMTFlYi1iOTI3LTU5NTBhYTc4NzgxZCJ9.4qvWx-fTgUnPgfhJ9MG8Sl2kBRYLhjg1jRvJCY_0IvU; SERVERID=b8715ff6359253839d01fc166a21cfe3|1622425050|1622425016")
    }
}
