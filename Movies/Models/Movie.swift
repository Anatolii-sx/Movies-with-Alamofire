//
//  Movie.swift
//  Movies
//
//  Created by Анатолий Миронов on 24.09.2021.
//

struct Movie: Decodable {
    let title: String?
    let poster: String?
    let ratingKinopoisk: String?
    let year: Int?
    let description: String?
    var genres: [String]?
    
    init(movie: [String: Any]) {
            self.title = movie["title"] as? String
            self.poster = movie["poster"] as? String
            self.ratingKinopoisk = movie["ratingKinopoisk"] as? String
            self.year = movie["year"] as? Int
            self.description = movie["description"] as? String
            self.genres = movie["genres"] as? [String]
    }
}

struct AllMoviesDescriptions: Decodable {
    let movies: [Movie]?
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    init(allMoviesDescriptions: [String: Any]) {
        movies = allMoviesDescriptions["movies"] as? [Movie] // Здесь "затык"
    }
    
    static func getMovies(value: Any) -> AllMoviesDescriptions {
        guard let allMovies = value as? [String: Any] else { return AllMoviesDescriptions(movies: []) }
        return AllMoviesDescriptions(allMoviesDescriptions: allMovies)
    }
}
