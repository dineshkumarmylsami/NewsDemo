//
//  FavoritesManagerTests.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import XCTest
@testable import NewsDemo

final class FavoritesManagerTests: XCTestCase {
    var manager: FavoritesManager!

    override func setUp() {
        super.setUp()
        manager = FavoritesManager.shared
        UserDefaults.standard.removeObject(forKey: KeyConstants.favArticlekey) // Clear favorites
    }

    func testSaveArticle_ShouldAddArticleToFavorites() {
        // Arrange
        let article = Article(source: nil ,
                              author: nil,
                              title: "Test Article",
                              description: "Test Description",
                              url: nil,
                              urlToImage: nil,
                              publishedAt: nil,
                              content: nil)
        
        // Act
        manager.saveArticle(article)
        
        // Assert
        let favorites = manager.fetchFavorites()
        XCTAssertEqual(favorites.count, 1)
        XCTAssertEqual(favorites.first?.title, "Test Article")
    }

    func testDeleteArticle_ShouldRemoveArticleFromFavorites() {
        // Arrange
        let article = Article(source: nil ,
                              author: nil,
                              title: "Test Article",
                              description: "Test Description",
                              url: nil,
                              urlToImage: nil,
                              publishedAt: nil,
                              content: nil)
        manager.saveArticle(article)
        
        // Act
        manager.deleteArticle(article)
        
        // Assert
        let favorites = manager.fetchFavorites()
        XCTAssertTrue(favorites.isEmpty)
    }
}
