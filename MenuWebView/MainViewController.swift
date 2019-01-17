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
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://papago.naver.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        preferredContentSize = NSSize(width: 400, height: 600)
    }
    
}

extension MainViewController: WKUIDelegate {
    
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
