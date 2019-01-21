//
//  AppDelegate.swift
//  MenuWebView
//
//  Created by United Merchant Services.inc on 1/17/19.
//  Copyright © 2019 GY. All rights reserved.
//

import Cocoa
import ServiceManagement



@NSApplicationMain


class AppDelegate: NSObject, NSApplicationDelegate {
    func acquirePrivileges() -> Bool {
        let accessEnabled = AXIsProcessTrustedWithOptions(
            [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary)
        if accessEnabled != true {
            print("You need to enable the keylogger in the System Prefrences")
        }
        return accessEnabled == true;
    }

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let _ = PopOverManageController.shared
        NSApp.setActivationPolicy(.prohibited)
        
        let launchAtLogIn = NSWorkspace.shared.runningApplications.contains{ $0.bundleIdentifier == Bundle.launchHelperBundleIdentifier }

        if launchAtLogIn {
            DistributedNotificationCenter.default().postNotificationName(.killMe,
                                                                         object: Bundle.main.bundleIdentifier,
                                                                         userInfo: nil,
                                                                         deliverImmediately: true)
        }
//        event.modifierFlags.intersection(.deviceIndependentFlagsMask)
        EventMonitor(mask: .keyDown) { (event) in
            guard let event = event else { return }
            switch event.modifierFlags.intersection(.deviceIndependentFlagsMask) {
                
            }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
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
