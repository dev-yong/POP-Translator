//
//  EventMonitor.swift
//  POP Translator
//
//  Created by United Merchant Services.inc on 1/17/19.
//  Copyright © 2019 GY. All rights reserved.
//

import Foundation
import Cocoa

class EventMonitor {
    typealias EventHandler = (NSEvent?) -> ()
    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    private let handler: EventHandler
    
    public init(mask: NSEvent.EventTypeMask, handler: @escaping EventHandler) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    public func start() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
    }
    
    public func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
}
