//
//  URLData.swift
//  MenuWebView
//
//  Created by 이광용 on 17/01/2019.
//  Copyright © 2019 GY. All rights reserved.
//

import Foundation


enum Translator: Int, CustomStringConvertible, CaseIterable {
    case google = 0, naver = 1, kakao = 2
    
    var description: String {
        switch self {
        case .google:
            return "Google"
        case .naver:
            return "Naver"
        case .kakao:
            return "Kakao i"
        }
    }
    
    var url: URL {
        var urlString: String
        switch self {
        case .google:
            urlString = "https://translate.google.com"
        case .naver:
            urlString = "https://papago.naver.com"
        case .kakao:
            urlString = "https://m.translate.kakao.com/"
        }
        guard let url = URL(string: urlString) else { fatalError("URL Converting is failed") }
        return url
    }
}

extension URL {
    var request: URLRequest {
        return URLRequest(url: self)
    }
}
