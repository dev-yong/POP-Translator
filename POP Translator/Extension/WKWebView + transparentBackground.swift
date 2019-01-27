//
//  WKWebView + transparentBackground.swift
//  POP Translator
//
//  Created by United Merchant Services.inc on 1/18/19.
//  Copyright © 2019 GY. All rights reserved.
//

import Cocoa
import WebKit

extension WKWebView {
    func transparentBackground() {
        if NSAppKitVersion.current.rawValue > 1500 {
            self.setValue(false, forKey: "drawsBackground")
        } else {
            self.setValue(true, forKey: "drawsTransparentBackground")
        }
    }
}
