//
//  MovieDbService.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 24/06/2021.
//

import Foundation
import Alamofire

final class MovieDbService {
    
    static let shared: MovieDbService = MovieDbService()
    
    private init() {}
    
    func fetchUpcomingMovieList(_ completion: @escaping (Result<Array<MovieList>, AFError>) -> Void) {
        AF.request(composeUrlString(subPath: "/movie/upcoming")).responseDecodable(of: Movies.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let movies = response.value {
                completion(.success(movies.movieList))
            }
        }.validate(statusCode: 200..<300)
    }
    
    private func composeUrlString(subPath: String) -> String {
        let path = subPath.first == "/" ? subPath : "/\(subPath)"
        return "\(baseURL)\(path)?api_key=\(apiKey)"
    }
}
