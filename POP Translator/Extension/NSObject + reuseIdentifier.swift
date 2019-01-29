//
//  NSObject + reuseIdentifier.swift
//  POP Translator
//
//  Created by 이광용 on 28/01/2019.
//  Copyright © 2019 GY. All rights reserved.
//

import Foundation

extension NSObject {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
