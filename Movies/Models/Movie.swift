//
//  Movie.swift
//  Movies
//
//  Created by Анатолий Миронов on 24.09.2021.
//

struct Movie: Decodable {
    let title: String?
    let poster: String?
    let rating_kinopoisk: String?
    let year: Int?
    let description: String?
    var genres: [String]?
    
    init(movie: [String: Any]) {
            self.title = movie["title"] as? String
            self.poster = movie["poster"] as? String
            self.rating_kinopoisk = movie["rating_kinopoisk"] as? String
            self.year = movie["year"] as? Int
            self.description = movie["description"] as? String
            self.genres = movie["genres"] as? [String]
    }
    
    static func getMovies(value: Any) -> [Movie] {
        guard let allData = value as? [String: Any] else { return [] }
        guard let movies = allData["movies"] as? [[String: Any]] else { return [] }
        
        return movies.compactMap { Movie(movie: $0) }
    }
}
