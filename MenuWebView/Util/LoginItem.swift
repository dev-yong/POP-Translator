//
//  LoginItem.swift
//  MenuWebView
//
//  Created by United Merchant Services.inc on 1/18/19.
//  Copyright © 2019 GY. All rights reserved.
//

import Foundation
import ServiceManagement

class LoginItem {
    
    static var isEnabled: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaults.Key.lauchAtLogIn.rawValue)
    }
    
    static func set(_ value: Bool, completion: @escaping(Bool)->()) {
        let success = SMLoginItemSetEnabled(Bundle.launchHelperBundleIdentifier as CFString, value)
        if success {
            UserDefaults.standard.set(value, forKey: UserDefaults.Key.lauchAtLogIn.rawValue)
        }
        completion(success)
    }
}
