//
//  ProductionCountryObject.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 18/08/2021.
//

import RealmSwift

class ProductionCountryEmbeddedObject: EmbeddedObject {
    @Persisted var name: String?
    @Persisted var iso3166_1: String?
    
    func convertToProductionCountry() -> ProductionCountry {
        ProductionCountry(iso3166_1: iso3166_1, name: name)
    }
}
