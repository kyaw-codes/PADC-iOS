//
//  RxActorRepository.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 08/09/2021.
//

import RxRealm
import RealmSwift
import RxSwift

protocol RxActorRepository {
    func saveActors(pageNo: Int?, actors: [Actor])
    func getActors(pageNo: Int?) -> Observable<[Actor]>
    func saveActorDetail(forActorId id: Int, detail: ActorDetailResponse)
    func getActorDetail(actorId id: Int) -> Observable<ActorDetailResponse>
}

final class RxActorRepositoryImpl: BaseRepository, RxActorRepository {
    
    static let shared: RxActorRepository = RxActorRepositoryImpl()
    
    private var disposeBag = DisposeBag()
    
    private override init() {}
    
    func saveActors(pageNo: Int?, actors: [Actor]) {
        let actorObjs = actors.map { $0.convertToActorObject(pageNo: pageNo ?? 1) }
        Observable.from(actorObjs)
            .subscribe(realm.rx.add(update: .modified))
            .disposed(by: disposeBag)
    }
    
    func getActors(pageNo: Int?) -> Observable<[Actor]> {
        let actorCollection: Results<ActorObject> = realm.objects(ActorObject.self)
        
        return Observable.collection(from: actorCollection)
            .flatMap { actorObj -> Observable<[Actor]> in
                Observable.of(actorObj.map { $0.convertToActor() })
            }
    }
    
    func saveActorDetail(forActorId id: Int, detail: ActorDetailResponse) {
        if let actorObj = realm.object(ofType: ActorObject.self, forPrimaryKey: id) {
            try? realm.write {
                actorObj.detail = detail.convertToActorDetailObj()
            }
        } else {
            let actorObj = ActorObject()
            actorObj.id = detail.id ?? -1
            actorObj.detail = detail.convertToActorDetailObj()
            
            try? realm.write {
                realm.add(actorObj, update: .modified)
            }
        }

    }
    
    func getActorDetail(actorId id: Int) -> Observable<ActorDetailResponse> {
        let actor = realm.object(ofType: ActorObject.self, forPrimaryKey: id)!
        return Observable.from(object: actor)
            .compactMap { $0.detail }
            .flatMap { detail in
                Observable.of(detail.convertToActorDetailResponse())
            }
    }

}
