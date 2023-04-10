//
//  ViewExpiredServicePresentationContract.swift
//  NCNUI
//
//  Created by raja-16327 on 09/04/23.
//

import Foundation
protocol ViewExpiredServiceViewContract: AnyObject {
    func load(message: String)
}

protocol ViewExpiredServicePresenterContract {
    func viewLoaded()
}

protocol ViewExpiredServiceRouterContract: AnyObject {
    func selected(message: String)
}
