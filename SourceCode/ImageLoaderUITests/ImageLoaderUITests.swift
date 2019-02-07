//
//  ImageLoaderUITests.swift
//  ImageLoaderUITests
//
//  Created by Viresh Singh on 07/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import XCTest

class ImageLoaderUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMovieListPopulation() {
        let app = XCUIApplication()
        let cellQuery = app.tables.cells.containing(.staticText, identifier: "movie_title")
        let cell = cellQuery.children(matching: .staticText)
        let cellElement = cell.element
        //Wait untill table loads
        self.waitForElementToAppear(cellElement)
        
        
        
        XCTAssertTrue(app.images["movie_image"].exists)
        //check number of cells loaded
        XCTAssertTrue(app.tables.cells.count  >= 33)
        
       
        
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["TheDark Knight "]/*[[".cells.matching(identifier: \"movie_cell\").staticTexts[\"TheDark Knight \"]",".staticTexts[\"TheDark Knight \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(2)
        let labelElement = app.staticTexts["movie_title"]
        XCTAssertNotNil(labelElement.value as! String)
        let labelElement1 = app.staticTexts["movie_subtitle"]
        XCTAssertNotNil(labelElement1.value as! String)
    }

    func waitForElementToAppear(_ element: XCUIElement) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }
}
