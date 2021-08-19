//
//  ProductionCompanyObject.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 18/08/2021.
//

import RealmSwift

class ProductionCompanyObject: Object {
    
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var logoPath: String?
    @Persisted var name: String?
    @Persisted var originCountry: String?
    
    func convertToProductionCompany() -> ProductionCompany {
        ProductionCompany(id: id, logoPath: logoPath, name: name, originCountry: originCountry)
    }
}
