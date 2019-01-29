//
//  File.swift
//  POP Translator
//
//  Created by United Merchant Services.inc on 1/17/19.
//  Copyright © 2019 GY. All rights reserved.
//

import Foundation
import Cocoa

class PopOverManageController: NSObject {
    static private let _shared = PopOverManageController()
    static var shared: PopOverManageController {
        return self._shared
    }
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    var eventMonitor2: EventMonitor?
    
    override init() {
        super.init()
        
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("Translator"))
            button.target = self
            button.action = #selector(togglePopover(_:))
        }
        
        popover.contentViewController = MainViewController.controller(storyboardName: .main)
        popover.contentSize = NSSize(width: 400, height: 400*16/9)
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let self = self else { return }
            if self.popover.isShown {
                self.closePopover(sender: event)
            }
        }
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            eventMonitor?.start()
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
}
