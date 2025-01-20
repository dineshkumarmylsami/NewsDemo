//
//  NewsDetailVMTests.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import XCTest
@testable import NewsDemo

final class NewsDetailVMTests: XCTestCase {
    var viewModel: NewsDetailVM!
    
    override func setUp() {
        super.setUp()
        viewModel = NewsDetailVM()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testToggleFavorite_ShouldAddArticleToFavorites_WhenNotFavorite() {
        // Arrange
        let article = Article(source: nil ,
                              author: nil,
                              title: "Test Article",
                              description: "Test Description",
                              url: nil,
                              urlToImage: nil,
                              publishedAt: nil,
                              content: nil)
        FavoritesManager.shared.deleteArticle(article) // Ensure it's not in favorites
        
        // Act
        let isFavorite = viewModel.toggleFavorite(isFavorite: false, article: article)
        
        // Assert
        XCTAssertTrue(isFavorite)
        XCTAssertTrue(FavoritesManager.shared.fetchFavorites().contains(where: { $0.title == article.title }))
    }

    func testToggleFavorite_ShouldRemoveArticleFromFavorites_WhenFavorite() {
        // Arrange
        let article = Article(source: nil ,
                              author: nil,
                              title: "Test Article",
                              description: "Test Description",
                              url: nil,
                              urlToImage: nil,
                              publishedAt: nil,
                              content: nil)
        FavoritesManager.shared.saveArticle(article) // Ensure it's in favorites
        
        // Act
        let isFavorite = viewModel.toggleFavorite(isFavorite: true, article: article)
        
        // Assert
        XCTAssertFalse(isFavorite)
        XCTAssertFalse(FavoritesManager.shared.fetchFavorites().contains(where: { $0.title == article.title }))
    }
}
