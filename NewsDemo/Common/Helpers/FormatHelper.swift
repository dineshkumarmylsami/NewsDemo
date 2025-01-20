//
//  FormatHelper.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import Foundation
/// Helper class to do all Formattings
struct FormatHelper {
    
    /// Helper function to format the published date
    /// - Parameter dateString: unformatted string
    /// - Returns: Formatted String
    static func formattedDate(from dateString: String) -> String {
       let dateFormatter = ISO8601DateFormatter()
       if let date = dateFormatter.date(from: dateString) {
           let outputFormatter = DateFormatter()
           outputFormatter.dateStyle = .medium
           outputFormatter.timeStyle = .short
           return outputFormatter.string(from: date)
       }
       return dateString
   }
    
}
