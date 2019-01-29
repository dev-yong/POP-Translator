//
//  NSViewController + create.swift
//  POP Translator
//
//  Created by 이광용 on 28/01/2019.
//  Copyright © 2019 GY. All rights reserved.
//

import Cocoa
protocol Controllable: class {
    associatedtype Controller = Self
    static func controller(storyboardName: NSStoryboard.Name) -> Controller
}

extension Controllable where Self: NSObject {
    static func controller(storyboardName: NSStoryboard.Name) -> Controller {
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(Self.reuseIdentifier)
        guard let controller = storyboard.instantiateController(withIdentifier: identifier) as? Controller else {
            fatalError("\(self.reuseIdentifier) is not found. Check \(storyboardName.description) ")
        }
        return controller
    }
}

extension NSViewController: Controllable {
}

extension NSWindowController: Controllable {
}
