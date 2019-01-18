//
//  IndicatorBox.swift
//  MenuWebView
//
//  Created by 이광용 on 18/01/2019.
//  Copyright © 2019 GY. All rights reserved.
//

import Cocoa

class IndicatorView: NSView {
    private var progressIndicator: NSProgressIndicator = NSProgressIndicator()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setUp()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 50, height: 50)
    }
    
    override var wantsUpdateLayer: Bool {
        return true
    }
    
    private func setUp() {
        self.wantsLayer = true
        self.layer?.cornerRadius = 5
        self.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.3).cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(progressIndicator)
        progressIndicator.style = .spinning
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        progressIndicator.sizeToFit()
        progressIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        progressIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stopAnimation(self)
    }
    
    override func layoutSubtreeIfNeeded() {
        
        super.layoutSubtreeIfNeeded()
        
        updateConstraints()
        
    }

    func startAnimation(_ sender: Any?) {
        self.progressIndicator.startAnimation(sender)
        NSAnimationContext.runAnimationGroup { (context) in
            context.duration = 0.5
            self.animator().alphaValue = 1.0
        }
    }
    
    func stopAnimation(_ sender: Any?) {
        self.progressIndicator.stopAnimation(sender)
        NSAnimationContext.runAnimationGroup { (context) in
            context.duration = 0.5
            self.animator().alphaValue = 0.0
        }
    }
    
    func set(_ value: Double) {
        self.progressIndicator.doubleValue = value
    }
}
