//
//  HotKey.swift
//  POP Translator
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

    init() {
        let _ = acquirePrivileges()
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
    
    func register(flag: NSEvent.ModifierFlags, keyCode: UInt16? = nil, handler: (()->Void)?) {
        eventMonitor = EventMonitor(mask: [.flagsChanged, .keyDown]) { (event) in
            guard let event = event else { return }
            
            switch event.modifierFlags.intersection(.deviceIndependentFlagsMask) {
            case flag where event.keyCode == keyCode:
                handler?()
            default:
                break
            }
        }
        
        eventMonitor?.start()
    }
}
