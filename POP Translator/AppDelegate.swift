//
//  AppDelegate.swift
//  POP Translator
//
//  Created by United Merchant Services.inc on 1/17/19.
//  Copyright © 2019 GY. All rights reserved.
//

import Cocoa
import ServiceManagement

//https://stackoverflow.com/questions/49716420/adding-a-global-monitor-with-nseventmaskkeydown-mask-does-not-trigger

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApp.setActivationPolicy(.prohibited)

        launchAtLogIn()
        
        PopOverManageController.shared
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func launchAtLogIn() {
        let isLaunchAtLogIn = NSWorkspace.shared.runningApplications.contains { $0.bundleIdentifier == Bundle.launchHelperBundleIdentifier }
        
        if isLaunchAtLogIn {
            DistributedNotificationCenter.default().postNotificationName(.killMe,
                                                                         object: Bundle.main.bundleIdentifier,
                                                                         userInfo: nil,
                                                                         deliverImmediately: true)
        }
    }
}

extension Bundle {
    static var launchHelperBundleIdentifier: String {
        return "com.gy.AutoLaunchHelper"
    }
}

extension NSNotification.Name {
    static var killMe: NSNotification.Name {
        return NSNotification.Name("KILLME")
    }
}