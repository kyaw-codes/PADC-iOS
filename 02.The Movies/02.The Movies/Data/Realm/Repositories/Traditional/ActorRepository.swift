//
//  ActorRepository.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 27/08/2021.
//

import RealmSwift

protocol ActorRepository {
    func saveActors(pageNo: Int?, actors: [Actor])
    func getActors(pageNo: Int?, completion: @escaping ([Actor]) -> Void)
    func saveActorDetail(forActorId id: Int, detail: ActorDetailResponse)
    func getActorDetail(actorId id: Int, completion: @escaping (ActorDetailResponse) -> Void)
}

class ActorRepositoryImpl: BaseRepository, ActorRepository {
    
    static let shared: ActorRepository = ActorRepositoryImpl()
    
    private let movieRepo = MovieRepositoryImpl.shared
    
    private override init() {
    }
    
    func saveActors(pageNo: Int?, actors: [Actor]) {
        let actorObjs: [ActorObject] = actors.map { $0.convertToActorObject(pageNo: pageNo ?? -1) }
        do {
            try realm.write {
                realm.add(actorObjs, update: .modified)
            }            
        } catch {
            print(error)
        }
    }
    
    func getActors(pageNo: Int?, completion: @escaping ([Actor]) -> Void) {
        let predicate = NSPredicate(format: "pageNo = %d", pageNo ?? -1)
        let objects: Results<ActorObject> = realm.objects(ActorObject.self).filter(predicate)
        completion(objects.map { $0.convertToActor() })
    }
    
    func saveActorDetail(forActorId id: Int, detail: ActorDetailResponse) {
        let detailObj = detail.convertToActorDetailObj()
        do {
            try realm.write {
                if let actorObj = realm.object(ofType: ActorObject.self, forPrimaryKey: id) {
                    actorObj.detail = detailObj
                }
            }
        } catch {
            print(error)
        }
    }

    func getActorDetail(actorId id: Int, completion: @escaping (ActorDetailResponse) -> Void) {
        if let detail = realm.object(ofType: ActorObject.self, forPrimaryKey: id)?.detail {
            completion(detail.convertToActorDetailResponse())
        }
    }

}
