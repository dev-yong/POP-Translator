//
//  AppDelegate.swift
//  AutoLaunchHelper
//
//  Created by United Merchant Services.inc on 1/18/19.
//  Copyright © 2019 GY. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
//https://stackoverflow.com/questions/35339277/make-swift-cocoa-app-launch-on-startup-on-os-x-10-11

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let alreadyRunning = NSWorkspace.shared.runningApplications.contains{ $0.bundleIdentifier == Bundle.targetBundleIdentifier }
        
        if alreadyRunning {
           self.terminate()
        }
        
        if !alreadyRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(terminate), name: .killMe, object: Bundle.targetBundleIdentifier)
            
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("MenuWebView")
            
            let newPath = NSString.path(withComponents: components)
            
            NSWorkspace.shared.launchApplication(newPath)
        }
        else {
            self.terminate()
        }

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func terminate() {
        NSApp.terminate(nil)
    }
}

extension Bundle {
    static var targetBundleIdentifier: String {
        return "com.gy.MenuWebView"
    }
}

extension NSNotification.Name {
    static var killMe: NSNotification.Name {
        return NSNotification.Name("KILLME")
    }
}
