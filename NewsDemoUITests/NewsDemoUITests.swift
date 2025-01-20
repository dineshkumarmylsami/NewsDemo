//
//  NewsDemoUITests.swift
//  NewsDemoUITests
//
//  Created by Dineshkumar on 19/01/25.
//

import XCTest

final class NewsDemoUITests: XCTestCase {

    let app = XCUIApplication()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testNewsListView_SegmentedControlToggles() {
        // Check that the "News" segment is selected by default
        let newsSegment = app.segmentedControls.buttons["News"]
        XCTAssertTrue(newsSegment.isSelected, "The 'News' segment should be selected by default.")
        
        // Tap the "Favorites" segment
        let favoritesSegment = app.segmentedControls.buttons["Favorites"]
        favoritesSegment.tap()
        XCTAssertTrue(favoritesSegment.isSelected, "The 'Favorites' segment should be selected after tapping.")
    }
    
    func testNewsListView_SearchBarFiltersArticles() {
        
        let newsSegment = app.segmentedControls.buttons["News"]
        newsSegment.tap()
        // Ensure the search bar is visible
        let searchBar = app.textFields["Search Articles"]
        XCTAssertTrue(searchBar.exists, "The search bar should be visible.")
        
       
    
    }
    // Unable to test below scenarios , since crossed 100 hits for given API.
   /*
    func testNewsListView_NavigatesToDetailView() {
        let newsSegment = app.segmentedControls.buttons["News"]
        newsSegment.tap()
        // Tap on the first article in the list
        let firstArticleCell = app.tables.cells.firstMatch
        XCTAssertTrue(firstArticleCell.exists, "There should be at least one article in the list.")
        
        firstArticleCell.tap()
        
        // Check if the detail view is displayed
        let detailViewTitle = app.staticTexts["Mock Test Article1"]
        XCTAssertTrue(detailViewTitle.exists, "The detail view should display the selected article title.")
    }
    
    func testNewsDetailView_DisplaysNavigationBarTitle() {
        // Navigate to the detail view
        app.tables.cells.firstMatch.tap()
        
        // Check if the navigation bar title is "Details"
        let navBarTitle = app.navigationBars.staticTexts["Details"]
        XCTAssertTrue(navBarTitle.exists, "The navigation bar title should be 'Details'.")
    }*/
}
