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
    // Used for Unit testing
    static var mockResponse: (data: Data?, error: URLError?)?
    
    /// Fetch Data
    /// - Parameter url: Url for which data need to be fetched
    /// - Returns: publish the fetched data or error
    static func fetchData(url: URL) -> AnyPublisher<Data, URLError> {
        if let mockResponse = mockResponse {
            if let data = mockResponse.data {
                return Just(data)
                    .setFailureType(to: URLError.self)
                    .eraseToAnyPublisher()
            } else if let error = mockResponse.error {
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
