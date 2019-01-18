//
//  URLData.swift
//  MenuWebView
//
//  Created by 이광용 on 17/01/2019.
//  Copyright © 2019 GY. All rights reserved.
//

import Foundation

struct Translator: Codable {
    var title: String
    var url: URL
    init(title: String, urlString: String) {
        self.title = title
        guard let url = URL(string: urlString) else { fatalError("URL Converting is failed") }
        self.url = url
    }
    
    static var sample: [Translator] {
        return [Translator(title: "Google", urlString: "https://translate.google.com"),
                Translator(title: "Papago", urlString: "https://papago.naver.com"),
                Translator(title: "Kakao i", urlString: "https://m.translate.kakao.com/")]
    }
}
