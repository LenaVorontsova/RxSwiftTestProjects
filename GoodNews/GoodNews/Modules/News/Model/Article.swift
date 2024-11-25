//
//  News.swift
//  GoodNews
//
//  Created by Елена Воронцова on 25.11.2024.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
}
