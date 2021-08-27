//
//  ActorModel.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 17/08/2021.
//

import Foundation

protocol ActorModel {
    
    func getActors(pageNo: Int?, completion: @escaping (Result<ActorResponse, Error>) -> Void)
    func getActorDetail(actorId id: Int, completion: @escaping (Result<ActorDetailResponse, Error>) -> Void)
    func getActorCredits(actorId id: Int, completion: @escaping (Result<ActorCreditResponse, Error>) -> Void)
}

final class ActorModelImpl: BaseModel, ActorModel {

    static let shared: ActorModel = ActorModelImpl()
    
    private let actorRepo = ActorRepositoryImpl.shared
    
    private override init() {
    }
    
    func getActors(pageNo: Int?, completion: @escaping (Result<ActorResponse, Error>) -> Void) {
        networkAgent.fetchActors(withEndpoint: .allActors(pageNo: pageNo ?? 1)) { [weak self] result in
            do {
                let actorResponse = try result.get()
                self?.actorRepo.saveActors(pageNo: actorResponse.page, actors: actorResponse.actors ?? [Actor]())
                self?.actorRepo.getActors(pageNo: actorResponse.page, completion: { actors in
                    completion(
                        .success(
                            ActorResponse(page: actorResponse.page,
                                          actors: actors,
                                          totalPages: actorResponse.totalPages,
                                          totalResults: actorResponse.totalResults)
                        )
                    )
                })
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getActorDetail(actorId id: Int, completion: @escaping (Result<ActorDetailResponse, Error>) -> Void) {
        networkAgent.fetchActorDetail(actorId: id) { [weak self] result in
            do {
                let actorDetail = try result.get()
                self?.actorRepo.saveActorDetail(forActorId: actorDetail.id ?? -1, detail: actorDetail)
                self?.actorRepo.getActorDetail(actorId: actorDetail.id ?? -1, completion: { detail in
                    completion(.success(detail))
                })
            } catch {
                completion(.failure(error))
            }
        }
    }

    func getActorCredits(actorId id: Int, completion: @escaping (Result<ActorCreditResponse, Error>) -> Void) {
        networkAgent.fetchMoviesRelatedTo(actorId: id) { result in
            do {
                let credits = try result.get()
                completion(.success(credits))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
