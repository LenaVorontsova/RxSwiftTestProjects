//
//  News.swift
//  GoodNews
//
//  Created by Елена Воронцова on 25.11.2024.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

extension ArticleResponse {
    static var all: Resource<ArticleResponse> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e5642ec49a244ad98f0a81772729d70c")!
        return Resource(url: url)
    }()
}

struct Article: Decodable {
    let title: String
    let description: String?
}
