//
//  NSViewController + create.swift
//  POP Translator
//
//  Created by 이광용 on 28/01/2019.
//  Copyright © 2019 GY. All rights reserved.
//

import Cocoa

extension NSViewController {
    static func create(storyboardName: NSStoryboard.Name) -> NSViewController {
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(self.reuseIdentifier)
        guard let viewController = storyboard.instantiateController(withIdentifier: identifier) as? NSViewController else {
            fatalError("Why cant i find \(self.reuseIdentifier)? - Check \(storyboardName.description)")
        }
        return viewController
    }
}
