//
//  APIConstants.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

/// Add other Langauges
enum Langauge {
    case English
}

///  Add other Countries
enum Country {
    case UnitedStates
}


/// This can be made dynamic when we have settings integration for API
struct ApiConstants {
    // API Key
    static let apiKeyValue = "97092ebaae684c34ac10de1c7ec86370"
    
    // Can be integrated in settings for user input
    // Supporting Langauage
    static let appSupportingLanguage: Langauge = .English
    
    // Supporting Country
    static let appSupportingCountry: Country = .UnitedStates
    
    // News Langauge
    static var appLanguage: String {
        switch appSupportingLanguage {
        case .English:
            return "en"
        }
    }
    
    // News for Countries
    static var newsCountry: String {
        switch appSupportingCountry {
        case .UnitedStates:
            return "us"
        }
    }
}
