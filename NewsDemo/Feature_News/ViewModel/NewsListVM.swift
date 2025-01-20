//
//  NewsListVM.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import Foundation
import Combine

final class NewsListVM: ObservableObject {
    // News list
    @Published var news: News?
    @Published var errorMessage: String?
    
    private var cancellables: Set<AnyCancellable> = []
    
    /// Fetch News
    func fetchNews() {
        if NetworkReachability.shared.isReachable {
            // Fetch from API if network is available
            fetchNewsFromAPI()
        } else {
            // Load from cache if offline
            loadNewsFromCache()
        }
    }

    /// Fetches news articles based on the selected category
    /// - Parameters:
    ///   - category: Temoprorarily category is not set , going with default one(that means all)
    ///   - searchQuery: Search field query
    func fetchNewsFromAPI(_ category: String? = nil, searchQuery: String? = nil) {
        // API key Setup
        guard let apiKey = KeychainManager.retrieve(key: KeyConstants.apiKeyName) else {
            errorMessage = "API Key not found"
            return
        }
        
        // Construct the URL with category and search query
        var urlString = "\(Config.baseURL)\(Config.urlPath)\(Config.apiKeyPath)\(apiKey)\(Config.country)\(Config.language)"
        
        if let category = category, !category.isEmpty {
            urlString += "&category=\(category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? category)"
        }
        
        // Query set up if any
        if let query = searchQuery, !query.isEmpty {
            urlString += "&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query)"
        }
   
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }
        
        // Fetch data from the API
        NetworkManager.fetchData(url: url)
            .decode(type: News.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Network Error: \(error.localizedDescription)")
                    self?.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] newsDetail in
                self?.news = newsDetail
                self?.cacheNews(newsDetail) // Update the cache
            })
            .store(in: &cancellables)
    }
    
    /// Handles search queries
    /// - Parameter query: Query string
    func searchNews(with query: String) {
        if query.isEmpty {
            fetchNews()
        } else {
            if NetworkReachability.shared.isReachable {
                fetchNewsFromAPI(searchQuery: query)
            }
            else {
                if let filteredArticles = news?.articles.filter({ $0.title?.lowercased().contains(query.lowercased()) ?? false }) {
                    news?.articles = filteredArticles
                }
            }
        }
    }
}

// Cache Handling
extension NewsListVM {

    /// Cache News
    /// - Parameter news: news to be saved
    func cacheNews(_ news: News) {
        if let data = try? JSONEncoder().encode(news) {
            UserDefaults.standard.set(data, forKey: KeyConstants.cacheKey)
        }
    }

    /// Load News from Cache
    func loadNewsFromCache() {
        if let data = UserDefaults.standard.data(forKey: KeyConstants.cacheKey),
           let cachedNews = try? JSONDecoder().decode(News.self, from: data) {
            self.news = cachedNews
        } else {
            errorMessage = "No cached data available"
        }
    }
}

