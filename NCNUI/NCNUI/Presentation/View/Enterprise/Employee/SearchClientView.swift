//
//  SearchClientView.swift
//  NCNUI
//
//  Created by raja-16327 on 31/03/23.
//

import AppKit
import Foundation
import NCN_BackEnd
class SearchClientView: NSView {
    public var employeeId: Int
    public var userId: Int
    var presenter: SearchClientPresenter

    init(userId: Int, employeeId: Int, presenter: SearchClientPresenter) {
        self.employeeId = employeeId

        self.presenter = presenter
        self.userId = userId
        super.init(frame: NSZeroRect)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidMoveToSuperview() {
        if superview != nil {
            presenter.viewLoaded(userId: userId, employeeId: employeeId)
        }
    }
}

extension SearchClientView: SearchClientViewContract {
    func load(response: String) {
        print(response)
    }

    func failed(error: String) {
        print(error)
    }
}
