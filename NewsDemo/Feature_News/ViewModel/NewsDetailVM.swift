//
//  NewsDetailVM.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import Foundation
/// News Detail ViewModel
class NewsDetailVM: ObservableObject {
    /// Toggle favorite state
    /// - Parameters:
    ///   - isFavorite: Boolean current state
    ///   - article: Article
    /// - Returns: Updated boolean state
    func toggleFavorite(isFavorite: Bool, article: Article) -> Bool {
        if isFavorite {
            FavoritesManager.shared.deleteArticle(article)
            return !isFavorite
        } else {
            FavoritesManager.shared.saveArticle(article)
            return !isFavorite
        }
    }
}
