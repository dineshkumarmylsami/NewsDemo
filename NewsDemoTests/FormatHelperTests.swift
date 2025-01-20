//
//  FormatHelperTests.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import XCTest
@testable import NewsDemo

final class FormatHelperTests: XCTestCase {
    func testFormattedDate_ShouldReturnFormattedString_WhenValidDateIsProvided() {
        // Arrange
        let isoDate = "2025-01-08T10:00:00Z"
        
        // Act
        let formattedDate = FormatHelper.formattedDate(from: isoDate)
        
        // Assert
        XCTAssertEqual(formattedDate, "8 Jan 2025 at 3:30 PM") // Adjust based on locale
    }

    func testFormattedDate_ShouldReturnOriginalString_WhenInvalidDateIsProvided() {
        // Arrange
        let invalidDate = "Invalid Date"
        
        // Act
        let formattedDate = FormatHelper.formattedDate(from: invalidDate)
        
        // Assert
        XCTAssertEqual(formattedDate, "Invalid Date")
    }
}
