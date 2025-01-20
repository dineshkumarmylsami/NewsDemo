//
//  NewsDemoApp.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import SwiftUI

@main
struct NewsDemoApp: App {
    /// Initialaisation For App
    init() {
        // API Key
        let apiKey = ApiConstants.apiKeyValue
        // Save Key
        KeychainManager.save(key: KeyConstants.apiKeyName, value: apiKey)
        
        if CommandLine.arguments.contains("--uitesting") {
                    //FavoritesManager.shared.deleteFavorites()
           // UserDefaults.standard.set(mockArticles, forKey: KeyConstants.favArticlekey)
        }
    }
    var body: some Scene {
        WindowGroup {
            NewsListView()
        }
    }
}
