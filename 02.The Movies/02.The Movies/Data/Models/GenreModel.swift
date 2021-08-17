//
//  GenreModel.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 17/08/2021.
//

import Foundation

protocol GenreModel {
    
    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void)
}

final class GenreModelImpl: BaseModel, GenreModel {

    static let shared: GenreModel = GenreModelImpl()
    
    private override init() {
    }
    
    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        networkAgent.fetchGenres(withEndpoint: .genres) { result in
            do {
                let genres = try result.get()
                completion(.success(genres))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
