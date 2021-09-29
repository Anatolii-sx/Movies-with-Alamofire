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
    case tokenOne = "45b5859b42728cda400e97b863ec99e9"
    case tokenTwo = "bacdec4f4887e5194399c412edc8302a"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    var url: String {
        "https://api.kinopoisk.cloud/movies/all/page/\(Int.random(in: 1...500))/token/\(Token.tokenTwo.rawValue)"
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
