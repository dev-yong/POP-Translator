//
//  AppDelegate.swift
//  POP Translator
//
//  Created by United Merchant Services.inc on 1/17/19.
//  Copyright © 2019 GY. All rights reserved.
//

import Cocoa
import ServiceManagement
import MASShortcut

//https://stackoverflow.com/questions/49716420/adding-a-global-monitor-with-nseventmaskkeydown-mask-does-not-trigger

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApp.setActivationPolicy(.prohibited)

        launchAtLogIn()
        
        //swiftlint:disable redundant_discardable_let
        let _ = PopOverManageController.shared
        registerShortcut()
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
    
    func registerShortcut() {
        MASShortcutValidator.shared()?.allowAnyShortcutWithOptionModifier = true
        MASShortcutBinder.shared()?.bindShortcut(withDefaultsKey: UserDefaults.Key.globalShortcut.rawValue, toAction: {
            PopOverManageController.shared.togglePopover(nil)
        })
        
        MASShortcutBinder.shared()?.registerDefaultShortcuts([UserDefaults.Key.globalShortcut.rawValue: MASShortcut(keyCode: UInt(kVK_ANSI_D), modifierFlags: NSEvent.ModifierFlags.shift.rawValue + NSEvent.ModifierFlags.option.rawValue)])
    }
}
