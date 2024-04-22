//
//  AppDelegate.swift
//  NCNUI
//
//  Created by raja-16327 on 13/03/23.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet var window: NSWindow!
    var router: Router?

    func applicationDidFinishLaunching(_: Notification) {
        // Insert code here to initialize your application
        window!.contentView = chunmaclass(frame: NSRect(x: 0, y: 0, width: 500, height: 500))
//        window.backgroundColor = .white
//        router = Router(window: window)
//        router?.launch()
    }

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_: NSApplication) -> Bool {
        return true
    }
}
