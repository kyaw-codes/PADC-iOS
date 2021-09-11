//
//  RxGenreModel.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 01/09/2021.
//

import Foundation
import RxSwift

protocol RxGenreModel {
    
    func getGenres() -> Observable<[Genre]>
}

final class RxGenreModelImpl: BaseModel, RxGenreModel {

    static let shared: RxGenreModel = RxGenreModelImpl()

    private let rxGenreRepo = RxGenreRepositoryImpl.shared
    private let disposeBag = DisposeBag()
    
    private override init() {
    }
    
    func getGenres() -> Observable<[Genre]> {
        rxNetworkAgent.fetchGenres(withEndpoint: .genres)
            .subscribe { genres in
                self.rxGenreRepo.saveGenres(genres: genres)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
        
        return self.rxGenreRepo.getGenres()
    }

}
