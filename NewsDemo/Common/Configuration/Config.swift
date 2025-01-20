//
//  Config.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import Foundation

enum Environment {
    case development
    // Future other environments can be added here
}

/// Environement Configuration Setup
struct Config {
    // Set current Environment
    static let currentEnvironment: Environment = .development // Switch as needed

    // Base URL
    static var baseURL: String {
        switch currentEnvironment {
        case .development:
            return "https://newsapi.org/v2/"
        }
    }
    
    // URL Path
    static var urlPath: String {
        switch currentEnvironment {
        case .development:
            return "top-headlines?"
        }
    }
    
    //Language supported for API Response
    static var language: String {
        switch currentEnvironment {
        case .development:
            return "&language=\(ApiConstants.appLanguage)"
        }
    }
    
    // Country news required for API Response
    static var country: String {
        switch currentEnvironment {
        case .development:
            return "&country=\(ApiConstants.newsCountry)"
        }
    }
    
    // API Key Path
    static var apiKeyPath: String {
        switch currentEnvironment {
        case .development:
            return "apiKey="
        }
    }
   
}
