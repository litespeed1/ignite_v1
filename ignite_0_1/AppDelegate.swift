//
//  AppDelegate.swift
//  ignite_0_1
//
//  Created by csimpson on 5/4/17.
//  Copyright © 2017 csimpson. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        
        if let button = statusItem.button {
            button.image = NSImage(named:"checkbox")
            button.title = "test"
//            button.action = Selector("printQuote:")
        }


    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

