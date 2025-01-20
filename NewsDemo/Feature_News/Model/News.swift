//
//  News.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import Foundation
/// News Model class
// MARK: - News
struct News: Codable, Hashable {
    let status: String
    let totalResults: Int
    var articles: [Article]
}

// MARK: - Article
struct Article: Codable,Hashable {
    let source: Source?
    let author: String?
    let title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable, Hashable {
    let id: String?
    let name: String?
}
