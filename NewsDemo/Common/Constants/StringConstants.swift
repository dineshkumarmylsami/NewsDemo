//
//  StringConstants.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

struct StringConstants {
    static let AppTitle = "NewsReader"
    static let SearchArticle = "Search Articles"
    static let NoArticle = "No articles available"
    
    static let DetailsTitle = "Details"
    static let authorByTitle =  "By"
    static let heartFill = "heart.fill"
    static let heartEmpty = "heart"
    
    enum Segments: String, CaseIterable {
        case News
        case Favorites
    }
}
