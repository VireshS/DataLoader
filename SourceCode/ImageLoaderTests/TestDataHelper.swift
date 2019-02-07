//
//  TestConstants.swift
//  ImageLoaderTests
//
//  Created by Viresh Singh on 07/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import Foundation

class TestDataHelper {
    private func validKeysJsonObject() -> String {
        return """
            {
                "Title": "Avengers:Age of Ultron ",
                "Year": "2015 ",
                "Rated": "PG-13 ",
                "Released": "01 May 2015 ",
                "Runtime": "141 min ",
                "Genre": "Action, Adventure, Sci-Fi ",
                "Director": "Joss Whedon ",
                "Writer": "Joss Whedon, Stan Lee (based on the Marvel comics by), Jack Kirby (based on the Marvel comics by), Joe Simon (character created by: Captain America), Jack Kirby (character created by: Captain America), Jim Starlin (character created by: Thanos) ",
                "Actors": "Robert Downey Jr., Chris Hemsworth, Mark Ruffalo, Chris Evans ",
                "Plot": "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan. ",
                "Language": "English, Korean ",
                "Country": "USA ",
                "Awards": "7 wins & 45 nominations.",
                "Poster": "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg ",
                "Metascore": "N/A ",
                "imdbRating": "N/A ",
                "imdbVotes": "N/A ",
                "imdbID": "tt1772315 ",
                "Type": "movie ",
                "DVD": "N/A ",
                "BoxOffice": "N/A ",
                "Production": "N/A ",
                "Website": "N/A ",
                "Response": "True "
            }
        """
    }
    
    private func inValidKeysJsonObject() -> String {
        return """
                {
                    "Title ": "Avengers:Age of Ultron ",
                    " Year ": "2015 ",
                    " Rated": "PG-13 ",
                    " Released ": "01 May 2015 ",
                    " Runtime": "141 min ",
                    "Genre ": "Action, Adventure, Sci-Fi ",
                    "Director": "Joss Whedon ",
                    "Writer ": "Joss Whedon, Stan Lee (based on the Marvel comics by), Jack Kirby (based on the Marvel comics by), Joe Simon (character created by: Captain America), Jack Kirby (character created by: Captain America), Jim Starlin (character created by: Thanos) ",
                    "Actors": "Robert Downey Jr., Chris Hemsworth, Mark Ruffalo, Chris Evans ",
                    "Plot ": "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan. ",
                    "Language ": "English, Korean ",
                    "Country": "USA ",
                    "Awards ": "7 wins & 45 nominations.",
                    "Poster ": "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg ",
                    " Metascore ": "N/A ",
                    "imdbRating": "N/A ",
                    "imdbVotes": "N/A ",
                    " imdbID": "tt1772315 ",
                    "Type": "movie ",
                    "DVD": "N/A ",
                    "BoxOffice": "N/A ",
                    "Production": "N/A ",
                    "Website": "N/A ",
                    "Response ": "True "
                }
        """
    }
    
    func invalidJson() -> String {
        return """
                    {
                        This is some text which is not a Valid Json object
                    }
                """
    }
    
    func singleValidJsonObject() ->String {
        return """
        {
        "movies": [
                    {
                        "Title": "Avengers:Age of Ultron ",
                        "Year": "2015 ",
                        "Rated": "PG-13 ",
                        "Released": "01 May 2015 ",
                        "Runtime": "141 min ",
                        "Genre": "Action, Adventure, Sci-Fi ",
                        "Director": "Joss Whedon ",
                        "Writer": "Joss Whedon, Stan Lee (based on the Marvel comics by), Jack Kirby (based on the Marvel comics by), Joe Simon (character created by: Captain America), Jack Kirby (character created by: Captain America), Jim Starlin (character created by: Thanos) ",
                        "Actors": "Robert Downey Jr., Chris Hemsworth, Mark Ruffalo, Chris Evans ",
                        "Plot": "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan. ",
                        "Language": "English, Korean ",
                        "Country": "USA ",
                        "Awards": "7 wins & 45 nominations.",
                        "Poster": "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg",
                    }
                ]
            }
        """
    }
    
    func testJsonDataWithInValidFormat(forMovieCount count:Int) -> String
    {
        var outerJson = """
                        {
                            "movies": [
                        """
        for _ in 1...count {
            outerJson = outerJson + self.inValidKeysJsonObject()
            outerJson = outerJson + ","
        }
        outerJson = outerJson + "]}"
        return outerJson
    }
    
    func testJsonDataWithValidFormat(forMovieCount count:Int) -> String
    {
        var outerJson = """
                        {
                            "movies": [
                        """
        for _ in 1...count {
            outerJson = outerJson + self.validKeysJsonObject()
            outerJson = outerJson + ","
        }
        outerJson = outerJson + "]}"
        return outerJson
    }
}
