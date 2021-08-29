//
//  BaseModel.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 17/08/2021.
//

import Foundation

class BaseModel {
    
    let networkAgent: NetworkAgent = NetworkAgentImpl.shared
    let rxNetworkAgent: RxNetworkAgent = RxNetworkAgentImpl.shared
}
