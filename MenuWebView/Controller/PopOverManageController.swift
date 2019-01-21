//
//  File.swift
//  MenuWebView
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
    
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    var eventMonitor2: EventMonitor?
    
    override init() {
        super.init()
        
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("StatusBarButtonImage"))
            button.target = self
            button.action = #selector(togglePopover(_:))
        }
        
        popover.contentViewController = PopOverManageController.freshController()
        popover.contentSize = NSSize(width: 400, height: 400*16/9)
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let self = self else { return }
            if self.popover.isShown {
                self.closePopover(sender: event)
            }
        }      
        
//        eventMonitor2 = EventMonitor(mask: NSEvent.EventTypeMask.flagsChanged, handler: { (event) in
//            guard let event = event else { return }
//            switch event.modifierFlags.intersection(.deviceIndependentFlagsMask) {
//            case [.shift]:
//                print("shift key is pressed")
//            case [.control]:
//                print("control key is pressed")
//            case [.option] :
//                print("option key is pressed")
//            case [.command]:
//                print("Command key is pressed")
//            case [.control, .shift]:
//                print("control-shift keys are pressed")
//            case [.option, .shift]:
//                print("option-shift keys are pressed")
//            case [.command, .shift]:
//                print("command-shift keys are pressed")
//            case [.control, .option]:
//                print("control-option keys are pressed")
//            case [.control, .command]:
//                print("control-command keys are pressed")
//            case [.option, .command]:
//                print("option-command keys are pressed")
//            case [.shift, .control, .option]:
//                print("shift-control-option keys are pressed")
//            case [.shift, .control, .command]:
//                print("shift-control-command keys are pressed")
//            case [.control, .option, .command]:
//                print("control-option-command keys are pressed")
//            case [.shift, .command, .option]:
//                print("shift-command-option keys are pressed")
//            case [.shift, .control, .option, .command]:
//                print("shift-control-option-command keys are pressed")
//            default:
//                print("no modifier keys are pressed")
//            }
//        })
//
//        eventMonitor2?.start()
        
        
        
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
    
    static func freshController() -> MainViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier("MainViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? MainViewController else {
            fatalError("Why cant i find MainViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}

