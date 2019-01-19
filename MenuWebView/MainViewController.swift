//
//  QuoteViewController.swift
//  MenuWebView
//
//  Created by United Merchant Services.inc on 1/17/19.
//  Copyright © 2019 GY. All rights reserved.
//

import Cocoa
import WebKit

class MainViewController: NSViewController {
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicatorView: IndicatorView!
    
    var translator = Translator.sample[2]
    var urlRequest: URLRequest {
        return URLRequest(url: self.translator.url)
    }
    private var minWidth: CGFloat = 400
    private var minHeight: CGFloat = 400*4/3
    private var observation: NSKeyValueObservation?
    
    deinit {
        if let observation = self.observation {
            NotificationCenter.default.removeObserver(observation)
        }
        observation = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.stringValue = translator.title
        
        let gesture = NSClickGestureRecognizer()
        gesture.buttonMask = 0x1 // left mouse
        gesture.numberOfClicksRequired = 1
        gesture.target = self
        gesture.action = #selector(reload)
        
        titleLabel.addGestureRecognizer(gesture)
    
    

        webView.load(urlRequest)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        preferredContentSize = NSSize(width: 400, height: 400*4/3)
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    
        observation = webView.observe(\WKWebView.estimatedProgress) { (webView, change) in
            DispatchQueue.main.async {
                self.setProgress(value: webView.estimatedProgress * 100)
            }
        }
    }
    
    private func setProgress(value: Double) {
        if value == 100 {
            indicatorView.stopAnimation(self)
        } else {
            indicatorView.startAnimation(self)
            indicatorView.set(value)
        }
    }
    
    @objc func reload() {
        webView.load(urlRequest)
    }
}

extension MainViewController: WKUIDelegate {
    
}

extension MainViewController: WKNavigationDelegate {
    
}

extension MainViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> MainViewController {
        //1.
        
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        
        let identifier = NSStoryboard.SceneIdentifier("QuotesViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? MainViewController else {
            fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}

struct Quote {
    let text: String
    let author: String
    
    static let all: [Quote] =  [
        Quote(text: "Never put off until tomorrow what you can do the day after tomorrow.", author: "Mark Twain"),
        Quote(text: "Efficiency is doing better what is already being done.", author: "Peter Drucker"),
        Quote(text: "To infinity and beyond!", author: "Buzz Lightyear"),
        Quote(text: "May the Force be with you.", author: "Han Solo"),
        Quote(text: "Simplicity is the ultimate sophistication", author: "Leonardo da Vinci"),
        Quote(text: "It’s not just what it looks like and feels like. Design is how it works.", author: "Steve Jobs")
    ]
}

extension Quote: CustomStringConvertible {
    var description: String {
        return "\"\(text)\" — \(author)"
    }
}
