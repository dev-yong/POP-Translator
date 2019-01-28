//
//  UserDefaults + Key.swift
//  POP Translator
//
//  Created by United Merchant Services.inc on 1/18/19.
//  Copyright © 2019 GY. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case lauchAtLogIn = "LAUNCHATLOGIN"
        case translator = "TRANSLATOR"
        case globalShortcut = "GLOBALSHORTCUT"
    }
}
