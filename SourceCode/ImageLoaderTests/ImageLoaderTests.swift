//
//  ImageLoaderTests.swift
//  ImageLoaderTests
//
//  Created by Viresh Singh on 06/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import XCTest
@testable import ImageLoader

class ImageLoaderTests: XCTestCase {

    var testHelper:TestDataHelper!
    override func setUp() {
        self.testHelper = TestDataHelper()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    //Tests if invalid json can be identified
    func testInvalidJson()
    {
        let jsonString = self.testHelper.invalidJson()
        let data = jsonString.data(using: .utf8)
        XCTAssertNotNil(data)
        XCTAssertTrue(data!.count>0)
        do {
            if let jsonData = try JSONSerialization.jsonObject(with:data!, options:.allowFragments) as? [String : AnyObject?]
            {
                XCTFail()
            }
        }
        catch{
            //If error occurs, it means test passes the expectation
        }
    }
    
    func testSingleMovieParsing() {
        let jsonString = self.testHelper.singleValidJsonObject()
        let data = jsonString.data(using: .utf8)
        XCTAssertNotNil(data)
        XCTAssertTrue(data!.count>0)
        do {
            if let jsonData = try JSONSerialization.jsonObject(with:data!, options:.allowFragments) as? [String : AnyObject?]
            {
                XCTAssertTrue(jsonData.count>0)
                let movies = Movie.moviesWith(jsonData: jsonData)
                XCTAssertNotNil(movies)
                XCTAssertTrue(movies?.count == 1)
                let anyMovie = movies?.first!
                XCTAssertNotNil(anyMovie?.Title)
                XCTAssertNotNil(anyMovie?.Year)
                XCTAssertNotNil(anyMovie?.Rated)
                XCTAssertNotNil(anyMovie?.Released)
                XCTAssertNotNil(anyMovie?.Runtime)
                XCTAssertNotNil(anyMovie?.Genre)
                XCTAssertNotNil(anyMovie?.Director)
                XCTAssertNotNil(anyMovie?.Writer)
                XCTAssertNotNil(anyMovie?.Actors)
                XCTAssertNotNil(anyMovie?.Plot)
                XCTAssertNotNil(anyMovie?.Language)
                XCTAssertNotNil(anyMovie?.Country)
                XCTAssertNotNil(anyMovie?.Awards)
                XCTAssertNotNil(anyMovie?.Poster)
                XCTAssertNil(anyMovie?.ImdbID)
                XCTAssertNil(anyMovie?.ImdbRating)
                XCTAssertNil(anyMovie?.ImdbRating)
            }
            else
            {
                XCTFail()
            }
        }
        catch{
            XCTFail()
        }
    }
    
    //Tests when json keys dont have space in their name and when few keys/value are might be missing
    func testMultipleValidMovieParsing() {
        let jsonString = self.testHelper.testJsonDataWithValidFormat(forMovieCount: 10)
        let data = jsonString.data(using: .utf8)
        XCTAssertNotNil(data)
        XCTAssertTrue(data!.count>0)
        do {
            if let jsonData = try JSONSerialization.jsonObject(with:data!, options:.allowFragments) as? [String : AnyObject?]
            {
                XCTAssertTrue(jsonData.count>0)
                let movies = Movie.moviesWith(jsonData: jsonData)
                XCTAssertNotNil(movies)
                XCTAssertTrue(movies?.count == 10)
                for anyMovie in movies!
                {
                    XCTAssertNotNil(anyMovie.Title)
                    XCTAssertNotNil(anyMovie.Year)
                    XCTAssertNotNil(anyMovie.Rated)
                    //Test other params as required
                }
            }
            else
            {
                XCTFail()
            }
        }
        catch{
            XCTFail()
        }
    }
    
    //Tests when json keys have space in their name and when few keys/value are might be missing
    func testMultipleInValidMovieParsing() {
        let jsonString = self.testHelper.testJsonDataWithInValidFormat(forMovieCount: 10)
        let data = jsonString.data(using: .utf8)
        XCTAssertNotNil(data)
        XCTAssertTrue(data!.count>0)
        do {
            if let jsonData = try JSONSerialization.jsonObject(with:data!, options:.allowFragments) as? [String : AnyObject?]
            {
                XCTAssertTrue(jsonData.count>0)
                let movies = Movie.moviesWith(jsonData: jsonData)
                XCTAssertNotNil(movies)
                XCTAssertTrue(movies?.count == 10)
                for anyMovie in movies!
                {
                    XCTAssertNotNil(anyMovie.Title)
                    XCTAssertNotNil(anyMovie.Year)
                    XCTAssertNotNil(anyMovie.Rated)
                    //Test other params as required
                }
            }
            else
            {
                XCTFail()
            }
        }
        catch{
            XCTFail()
        }
    }

    func testJsonParsingPerformance() {
        // Test how much performance it hits while parsing big jsons
        self.measure {
            let jsonString = self.testHelper.testJsonDataWithInValidFormat(forMovieCount: 100)
            let data = jsonString.data(using: .utf8)
            XCTAssertNotNil(data)
            XCTAssertTrue(data!.count>0)
            do {
                if let jsonData = try JSONSerialization.jsonObject(with:data!, options:.allowFragments) as? [String : AnyObject?]
                {
                    XCTAssertTrue(jsonData.count>0)
                    let movies = Movie.moviesWith(jsonData: jsonData)
                    XCTAssertNotNil(movies)
                    XCTAssertTrue(movies?.count == 100)
                }
            }
            catch{
                XCTFail()
            }
        }
    }

}
