//
//  FavoritesManager.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//
import Foundation
/// Favorites Manager
class FavoritesManager {
    static let shared = FavoritesManager()
    
    /// Save Article
    /// - Parameter article: Article to be saved
    func saveArticle(_ article: Article) {
        var favorites = fetchFavorites()
        if !favorites.contains(where: { $0.title == article.title }) {
            favorites.append(article)
            if let data = try? JSONEncoder().encode(favorites) {
                UserDefaults.standard.set(data, forKey: KeyConstants.favArticlekey)
            }
        }
    }
    
    /// Delete Article
    /// - Parameter article: Article to be Deleted
    func deleteArticle(_ article: Article) {
        var favorites = fetchFavorites()
        favorites.removeAll { $0.title == article.title }
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: KeyConstants.favArticlekey)
        }
    }
    
    /// Fetch all Articles
    /// - Returns: List of Articles saved
    func fetchFavorites() -> [Article] {
        if let data = UserDefaults.standard.data(forKey: KeyConstants.favArticlekey),
           let favorites = try? JSONDecoder().decode([Article].self, from: data) {
            return favorites
        }
        return []
    }
    
    func deleteFavorites() {
        var favorites = fetchFavorites()
        favorites.removeAll()
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: KeyConstants.favArticlekey)
        }
    }
}
