//
//  NetworkManager.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import Foundation
import Combine

/// Network Manager
class NetworkManager {
    
    /// Fetch Data
    /// - Parameter url: Url for which data need to be fetched
    /// - Returns: publish the fetched data or error
    static func fetchData(url: URL) -> AnyPublisher<Data, URLError> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
