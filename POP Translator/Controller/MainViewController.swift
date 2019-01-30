//
//  QuoteViewController.swift
//  POP Translator
//
//  Created by United Merchant Services.inc on 1/17/19.
//  Copyright © 2019 GY. All rights reserved.
//

import Cocoa
import WebKit

class MainViewController: NSViewController {
    
    @IBOutlet weak var shortcutView: MASShortcutView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    @IBOutlet weak var settingButton: NSButton!
    @IBOutlet weak var launchAtLogInButton: NSButton!
    
    private var translator: Translator = .google {
        willSet {
            updateUI(newValue)
        }
    }
    
    private var translatorMenuItems: [NSMenuItem] = {
        let items = Translator.allCases.enumerated().map {
            return NSMenuItem(title: $1.description, action: #selector(changeTranslator(_:)), keyEquivalent: "\($0 + 1)")
        }
        items.enumerated().forEach { $1.representedObject = Translator.allCases[$0] }
        return items
    }()
    
    private let mainMenu = NSMenu()

    private var observations: [NSKeyValueObservation] = []

    deinit {
        observations.forEach { NotificationCenter.default.removeObserver($0) }
        observations.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUplabel()
        setUpWebView()
        setUpMenu()
        
        if let value = UserDefaults.standard.value(forKey: UserDefaults.Key.translator.rawValue) as? Translator.RawValue,
            let translator = Translator(rawValue: value) {
            self.translator = translator
        }
        updateUI(translator)
        
        launchAtLogInButton.state = LoginItem.isEnabled ? .on : .off

        shortcutView.associatedUserDefaultsKey = UserDefaults.Key.globalShortcut.rawValue
    }
    
    private func setProgress(value: Double) {
        progressIndicator.doubleValue = value
        progressIndicator.isHidden = value == 100
    }
    
    private func setUplabel() {
        let gesture = NSClickGestureRecognizer()
        gesture.buttonMask = 0x1 // left mouse
        gesture.numberOfClicksRequired = 1
        gesture.target = self
        gesture.action = #selector(loadHome)
    }
    
    private func setUpWebView() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.transparentBackground()
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        progressIndicator.startAnimation(self)
        observations.append(webView.observe(\WKWebView.estimatedProgress) { (webView, _) in
            DispatchQueue.main.async {
                self.setProgress(value: webView.estimatedProgress * 100)
            }
        })
    }
    
    private func setUpMenu() {
        mainMenu.addItem(NSMenuItem(title: "Home", action: #selector(loadHome), keyEquivalent: "h"))
        mainMenu.addItem(NSMenuItem.separator())
        translatorMenuItems.forEach { mainMenu.addItem($0) }
        mainMenu.addItem(NSMenuItem.separator())
        mainMenu.addItem(NSMenuItem(title: "Open Source", action: #selector(openLicense), keyEquivalent: "l"))
        mainMenu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        settingButton.menu = mainMenu
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.modifierFlags.intersection(.deviceIndependentFlagsMask) {
        case [.command]:
            guard let character = event.characters else { return }
            switch character {
            case "1":
                translator = Translator.allCases[0]
            case "2":
                translator = Translator.allCases[1]
            case "3":
                translator = Translator.allCases[2]
            case "h":
                loadHome()
            case "r":
                webView.reload()
            case "l":
                openLicense()
            default:
                break
            }
        default:
            break
        }
    }
    
    @objc func changeTranslator(_ sender: NSMenuItem) {
        
        guard let item = sender.representedObject as? Translator else { return }
        translator = item
        updateUI(item)
        UserDefaults.standard.set(translator.rawValue, forKey: UserDefaults.Key.translator.rawValue)
    }
    
    private func updateUI(_ item: Translator) {
        DispatchQueue.main.async {
            self.webView.load(item.url.request)
            self.mainMenu.items.forEach { $0.state = ($0.representedObject as? Translator) == item ? .on : .off }
        }
    }
    
    @IBAction func settingButtonClicked(_ sender: NSButton) {
        sender.menu?.popUp(positioning: nil, at: NSPoint(x: 0, y: sender.frame.height + 5), in: sender)
    }
    
    @objc private func loadHome() {
        webView.load(translator.url.request)
    }

    @IBAction func lauchAtLogInButtonClicked(_ sender: NSButton) {
        let isOn = sender.state == .on
        LoginItem.set(isOn) { (success) in
            if success {
                sender.state = isOn ? .on : .off
            } else {
                sender.state = !isOn ? .on : .off
            }
        }
    }
    
    @objc private func openLicense() {
        if let filePath = Bundle.main.path(forResource: "Licenses", ofType: "rtf") {
            NSWorkspace.shared.openFile(filePath, withApplication: "TextEdit")
        }
    }
}

extension MainViewController: WKUIDelegate {
    
}

extension MainViewController: WKNavigationDelegate {
    
}
