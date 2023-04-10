//
//  ViewExpiredServiceView.swift
//  NCNUI
//
//  Created by raja-16327 on 09/04/23.
//

import Foundation
import AppKit

class ViewExpiredServiceView: NSView {
    
    public var employeeId: Int
    
    var presenter: ViewExpiredServicePresenter
    
    init(  employeeId: Int, presenter: ViewExpiredServicePresenter) {
        
        self.employeeId = employeeId
        
        self.presenter = presenter
        super.init(frame: NSZeroRect)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        if superview != nil {
            presenter.viewLoaded()
        }
    }
}

extension ViewExpiredServiceView: ViewExpiredServiceViewContract {
    func load(message: String) {
        print(message)
    }
    
    func failed(error: String) {
        print(error)
    }
}

