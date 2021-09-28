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
    let genres: [String]?
}

struct AllMoviesDescriptions: Decodable {
    let movies: [Movie]?
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    init(allMoviesDescriptions: [String: Any]) {
        movies = allMoviesDescriptions["movies"] as? [Movie]
    }
    
    static func getMovies(value: Any) -> AllMoviesDescriptions {
        guard let allMovies = value as? [String: Any] else { return AllMoviesDescriptions(movies: []) }
        return AllMoviesDescriptions(allMoviesDescriptions: allMovies)
    }
}
