//
//  NewsListVMTests.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import XCTest
import Combine
@testable import NewsDemo

final class NewsListViewModelTests: XCTestCase {
    var viewModel: NewsListVM!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = NewsListVM()
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchNewsFromAPI_WithValidResponse_ShouldUpdateNews() {
        // Arrange
        let mockNews = News(
            status: "ok",
            totalResults: 2,
            articles: [
                Article(
                    source: nil,
                    author: nil,
                    title: "Mock Test Article1",
                    description: "Mock Test Description1",
                    url: nil,
                    urlToImage: nil,
                    publishedAt: nil,
                    content: nil
                ),
                Article(
                    source: nil,
                    author: nil,
                    title: "Mock Test Article2",
                    description: "Mock Test Description2",
                    url: nil,
                    urlToImage: nil,
                    publishedAt: nil,
                    content: nil
                )
            ]
        )
        
        let mockData = try! JSONEncoder().encode(mockNews)
        NetworkManager.mockResponse = (mockData, nil) // Mock network response

        // Act
        viewModel.fetchNewsFromAPI()

        // Assert
        let expectation = XCTestExpectation(description: "Fetch news updates the news property")
        viewModel.$news
            .dropFirst()
            .sink { news in
                XCTAssertEqual(news?.articles.first?.title, "Mock Test Article1")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }


    func testFetchNewsFromCache_ShouldUpdateNews_WhenCacheExists() {
        // Arrange
        let cachedNews = News(status: "ok", totalResults: 2, articles: [
            Article(source: nil ,
                                 author: nil,
                                 title: "Cached Test Article1",
                                 description: "Cached Test Description1",
                                 url: nil,
                                 urlToImage: nil,
                                 publishedAt: nil,
                                 content: nil),
            Article(source: nil, author: nil, title: " Cached Test Article2", description: " Cached Test Description2", url: nil, urlToImage: nil, publishedAt: nil,content: nil)])
        let cachedData = try! JSONEncoder().encode(cachedNews)
        UserDefaults.standard.set(cachedData, forKey: KeyConstants.cacheKey)

        // Act
        viewModel.loadNewsFromCache()

        // Assert
        XCTAssertEqual(viewModel.news?.articles.first?.title, "Cached Test Article1")
    }

    func testSearchNews_ShouldFilterNews_WhenQueryIsProvided() {
        // Arrange
        viewModel.news = News(status: "ok", totalResults: 1, articles: [
             Article(source: nil ,
                                  author: nil,
                                  title: "Test Article1",
                                  description: "Test Description1",
                                  url: nil,
                                  urlToImage: nil,
                                  publishedAt: nil,
                                  content: nil),
             Article(source: nil, author: nil, title: "Test Article2", description: "Test Description2", url: nil, urlToImage: nil, publishedAt: nil,content: nil)])
        
        // Act
        viewModel.searchNews(with: "Apple")
        
        // Assert
        XCTAssertEqual(viewModel.news?.articles.count, 2)
        XCTAssertEqual(viewModel.news?.articles.first?.title, "Test Article1")
    }
}
