//
//  ProductionCountryObject.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 18/08/2021.
//

import RealmSwift

class ProductionCountryObject: Object {
    @Persisted(primaryKey: true) var name: String?
    @Persisted var iso3166_1: String?
}
