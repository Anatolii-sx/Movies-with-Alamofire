//
//  NetworkManager.swift
//  Movies
//
//  Created by Анатолий Миронов on 26.09.2021.
//

import Foundation
import Alamofire

// You can use 1 token for only 10 free requests
enum Token: String {
    case tokenOne = "f9b1c2c02f9919bf405d41f2cd177bf9"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    var url: String {
        "https://api.kinopoisk.cloud/movies/all/page/\(Int.random(in: 1...500))/token/\(Token.tokenOne.rawValue)"
    }
    
    init() {}
    
    func fetchMovies(url: String, completion: @escaping (Result<AllMoviesDescriptions, NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                print(dataResponse)
                switch dataResponse.result {
                case .success(let value):
                    let movies = AllMoviesDescriptions.getMovies(value: value)
                    DispatchQueue.main.async {
                        completion(.success(movies))
                    }
                case .failure(_):
                    completion(.failure(.decodingError))
                }
            }
    }
}
