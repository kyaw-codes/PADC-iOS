//
//  RxActorModel.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 08/09/2021.
//

import RxSwift

protocol RxActorModel {
    
    func getActors(pageNo: Int?) -> Observable<ActorResponse>
    func getActorDetail(actorId id: Int) -> Observable<ActorDetailResponse>
    func getActorCredits(actorId id: Int) -> Observable<ActorCreditResponse>
}

final class RxActorModelImpl: BaseModel, RxActorModel {
    
    static let shared: RxActorModel = RxActorModelImpl()
    
    private let rxActorRepo = RxActorRepositoryImpl.shared
    private let rxMovieRepo = RxMovieRepositoryImpl.shared
    
    private override init() {}
    
    func getActors(pageNo: Int?) -> Observable<ActorResponse> {
        rxNetworkAgent.fetchActors(withEndpoint: .allActors(pageNo: pageNo ?? 1))
            .do { [weak self] response in
                self?.rxActorRepo.saveActors(pageNo: pageNo, actors: response.actors ?? [Actor]())
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { response in
                self.rxActorRepo.getActors(pageNo: pageNo)
                    .flatMap { actors in
                        return Observable.of(ActorResponse(page: response.page, actors: actors, totalPages: response.totalPages, totalResults: response.totalResults))
                    }
            }
    }
    
    func getActorDetail(actorId id: Int) -> Observable<ActorDetailResponse> {
        rxNetworkAgent.fetchActorDetail(actorId: id)
            .do { [weak self] response in
                self?.rxActorRepo.saveActorDetail(forActorId: id, detail: response)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { response in
                self.rxActorRepo.getActorDetail(actorId: response.id ?? -1)
            }
    }
    
    func getActorCredits(actorId id: Int) -> Observable<ActorCreditResponse> {
        rxNetworkAgent.fetchMoviesRelatedTo(actorId: id)
    }
    
    
    
}
