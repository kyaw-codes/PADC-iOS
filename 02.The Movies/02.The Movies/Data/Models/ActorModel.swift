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
    
    private override init() {
    }
    
    func getActors(pageNo: Int?, completion: @escaping (Result<ActorResponse, Error>) -> Void) {
        networkAgent.fetchActors(withEndpoint: .allActors(pageNo: pageNo ?? 1)) { result in
            do {
                let actorResponse = try result.get()
                completion(.success(actorResponse))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getActorDetail(actorId id: Int, completion: @escaping (Result<ActorDetailResponse, Error>) -> Void) {
        networkAgent.fetchActorDetail(actorId: id) { result in
            do {
                let actorDetail = try result.get()
                completion(.success(actorDetail))
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
