//
//  test.swift
//  NCNUI
//
//  Created by raja-16327 on 28/04/23.
//

import Foundation
import AppKit

public class chunmaclass: NSView {
    
    var textField: NSTextField
    
    public override init(frame frameRect: NSRect) {
        textField = NSTextField()
        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        textField.isEditable = false
        textField.isBordered = false
        textField.isSelectable = false
        textField.font = NSFont.systemFont(ofSize: 40)
        textField.stringValue = " Hello "
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
