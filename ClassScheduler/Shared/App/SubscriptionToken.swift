//
//  SubscriptionToken.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import Combine

class SubscriptionToken {
    var cancellable: AnyCancellable?
    func unseal() { cancellable = nil }
}
