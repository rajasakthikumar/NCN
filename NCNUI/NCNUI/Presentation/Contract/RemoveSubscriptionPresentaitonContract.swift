//
//  RemoveSubscriptionPresentaitonContract.swift
//  NCNUI
//
//  Created by raja-16327 on 12/04/23.
//

import Foundation
protocol RemoveSubscriptionViewContract: AnyObject {
    func load(message: String)
}

protocol RemoveSubscriptionPresenterContract {
    func viewLoaded(subscriptionId: Int)
}

protocol RemoveSubscriptionRouterContract: AnyObject {
    func selected(message: String)
}
