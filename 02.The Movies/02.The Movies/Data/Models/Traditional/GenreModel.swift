//
//  GenreModel.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 17/08/2021.
//

import Foundation
import RxSwift

protocol GenreModel {
    
    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void)
}

final class GenreModelImpl: BaseModel, GenreModel {

    static let shared: GenreModel = GenreModelImpl()
    
    private let genreRepo = GenreRepositoryImpl.shared
    
    private override init() {
    }
    
    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        networkAgent.fetchGenres(withEndpoint: .genres) { [weak self] result in
            do {
                let genres = try result.get()
                self?.genreRepo.saveGenres(genres: genres)
                
                self?.genreRepo.getGenres { completion(.success($0)) }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
