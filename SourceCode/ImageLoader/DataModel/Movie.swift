//
//  Movie.swift
//  ImageLoader
//
//  Created by Viresh Singh on 06/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import UIKit


class Movie: CustomStringConvertible,Codable {
    
    var Title:String?           = nil
    var Year:String?            = nil
    var Rated:String?           = nil
    var Released:String?        = nil
    var Runtime:String?         = nil
    var Genre:String?           = nil
    var Director:String?        = nil
    var Writer:String?          = nil
    var Actors:String?          = nil
    var Plot:String?            = nil
    var Language:String?        = nil
    var Country:String?         = nil
    var Awards:String?          = nil
    var Poster:String?          = nil
    var Ratings:String?         = nil
    var Metascore:String?       = nil
    var ImdbRating:String?      = nil
    var ImdbVotes:String?       = nil
    var ImdbID:String?          = nil
    var DVD:String?             = nil
    var BoxOffice:String?       = nil
    var Production:String?      = nil
    var Website:String?         = nil
    var Response:String?        = nil
    
    ///Provides debug descrption of the sender
    var description: String
    {
        return "Movie Name:\(self.Title ?? ""), Year:\(self.Year ?? ""), Poster:\(self.Poster ?? "")"
    }
    
    ///Creates movie objects from given Json data
    class func moviesWith(jsonData jsnData:[String:AnyObject?])->[Movie]?
    {
        if let allJsonMovies = jsnData["movies"] as? [[String:AnyObject?]]
        {
            if(allJsonMovies.count>0)
            {
                var allParsedMovies = [Movie]()
                //Iterate throught he all json models
                for jsonMovie in allJsonMovies
                {
                    let newMovie = Movie()
                    for originalKey in jsonMovie.keys
                    {
                        //Take all keys for given Movie Json object and sanitize it for inconsistent naming
                        let finalKey = originalKey.trim().lowercased()
                        if(finalKey == "title")
                        {
                            if let title = jsonMovie[originalKey] as? String
                            {
                                newMovie.Title = title
                            }
                        }
                        else if(finalKey == "year")
                        {
                            if let year = jsonMovie[originalKey] as? String
                            {
                                newMovie.Year = year
                            }
                        }
                        else if(finalKey == "rated")
                        {
                            if let rated = jsonMovie[originalKey] as? String
                            {
                                newMovie.Rated = rated
                            }
                        }
                        else if(finalKey == "released")
                        {
                            if let released = jsonMovie[originalKey] as? String
                            {
                                newMovie.Released = released
                            }
                        }
                        else if(finalKey == "runtime")
                        {
                            if let runtime = jsonMovie[originalKey] as? String
                            {
                                newMovie.Runtime = runtime
                            }
                        }
                        else if(finalKey == "genre")
                        {
                            if let genre = jsonMovie[originalKey] as? String
                            {
                                newMovie.Genre = genre
                            }
                        }
                        else if(finalKey == "director")
                        {
                            if let director = jsonMovie[originalKey] as? String
                            {
                                newMovie.Director = director
                            }
                        }
                        else if(finalKey == "writer")
                        {
                            if let writer = jsonMovie[originalKey] as? String
                            {
                                newMovie.Writer = writer
                            }
                        }
                        else if(finalKey == "actors")
                        {
                            if let actors = jsonMovie[originalKey] as? String
                            {
                                newMovie.Actors = actors
                            }
                        }
                        else if(finalKey == "plot")
                        {
                            if let plot = jsonMovie[originalKey] as? String
                            {
                                newMovie.Plot = plot
                            }
                        }
                        else if(finalKey == "language")
                        {
                            if let lanuage = jsonMovie[originalKey] as? String
                            {
                                newMovie.Language = lanuage
                            }
                        }
                        else if(finalKey == "country")
                        {
                            if let country = jsonMovie[originalKey] as? String
                            {
                                newMovie.Country = country
                            }
                        }
                        else if(finalKey == "awards")
                        {
                            if let awards = jsonMovie[originalKey] as? String
                            {
                                newMovie.Awards = awards
                            }
                        }
                        else if(finalKey == "poster")
                        {
                            if let poster = jsonMovie[originalKey] as? String
                            {
                                newMovie.Poster = poster
                            }
                        }
                        else if(finalKey == "ratings")
                        {
                            if let ratings = jsonMovie[originalKey] as? String
                            {
                                newMovie.Ratings = ratings
                            }
                        }
                        else if(finalKey == "metascore")
                        {
                            if let metascore = jsonMovie[originalKey] as? String
                            {
                                newMovie.Metascore = metascore
                            }
                        }
                        else if(finalKey == "imdbrating")
                        {
                            if let imdbRating = jsonMovie[originalKey] as? String
                            {
                                newMovie.ImdbRating = imdbRating
                            }
                        }
                        else if(finalKey == "imdbvotes")
                        {
                            if let imdbVotes = jsonMovie[originalKey] as? String
                            {
                                newMovie.ImdbVotes = imdbVotes
                            }
                        }
                        else if(finalKey == "imdbid")
                        {
                            if let imdbID = jsonMovie[originalKey] as? String
                            {
                                newMovie.ImdbID = imdbID
                            }
                        }
                        else if(finalKey == "dvd")
                        {
                            if let dvd = jsonMovie[originalKey] as? String
                            {
                                newMovie.DVD = dvd
                            }
                        }
                        else if(finalKey == "boxoffice")
                        {
                            if let boxOffice = jsonMovie[originalKey] as? String
                            {
                                newMovie.BoxOffice = boxOffice
                            }
                        }
                        else if(finalKey == "production")
                        {
                            if let production = jsonMovie[originalKey] as? String
                            {
                                newMovie.Production = production
                            }
                        }
                        else if(finalKey == "website")
                        {
                            if let website = jsonMovie[originalKey] as? String
                            {
                                newMovie.Website = website
                            }
                        }
                        else if(finalKey == "response")
                        {
                            if let response = jsonMovie[originalKey] as? String
                            {
                                newMovie.Response = response
                            }
                        }
                    }
                    allParsedMovies.append(newMovie)
                }
                return allParsedMovies
            }
        }
        return nil
    }
}
