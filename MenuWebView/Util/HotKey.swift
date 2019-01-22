//
//  HotKey.swift
//  MenuWebView
//
//  Created by 이광용 on 21/01/2019.
//  Copyright © 2019 GY. All rights reserved.
//

import Foundation
import Cocoa

class HotKey {
    static private var _shared: HotKey = HotKey()
    static var shared: HotKey {
        return _shared
    }
    
    private var eventMonitor: EventMonitor?
    var isAccessable: Bool {
        return AXIsProcessTrustedWithOptions(
            [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary)
    }
    
    var flag: NSEvent.ModifierFlags = [.command, .shift]
    var keyCode = 0x03
    
    init() {
        let _ = acquirePrivileges()
        eventMonitor = EventMonitor(mask: .keyDown) { (event) in
            guard let event = event else { return }
            
            switch event.modifierFlags.intersection(.deviceIndependentFlagsMask) {
            case self.flag where event.keyCode == self.keyCode:
                PopOverManageController.shared.togglePopover(nil)
            default:
                break
            }
        }
        
        eventMonitor?.start()
    }
    
    deinit {
        eventMonitor?.stop()
    }
    
    func acquirePrivileges() -> Bool {
        if !isAccessable {
            print("You need to enable the keylogger in the System Prefrences")
        }
        return isAccessable
    }
}
