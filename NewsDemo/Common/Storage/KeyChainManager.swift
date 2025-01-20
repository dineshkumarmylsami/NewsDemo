//
//  KeyChainManager.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import Foundation
import Security
// Keychain Manager to save API Keys
final class KeychainManager {
    /// Save API Key
    /// - Parameters:
    ///   - key: key to the value
    ///   - value: value to store
    static func save(key: String, value: String) {
        let data = value.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary) // Remove existing item
        SecItemAdd(query as CFDictionary, nil)
    }
    
    /// Retrieve API Key
    /// - Parameter key: Key to the Value stored
    /// - Returns: Key for API
    static func retrieve(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
