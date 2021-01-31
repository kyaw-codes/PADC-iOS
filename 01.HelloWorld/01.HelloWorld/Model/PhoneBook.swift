//
//  PhoneBook.swift
//  01.HelloWorld
//
//  Created by Ko Kyaw on 22/01/2021.
//

import Foundation

struct PhoneBook {
    
    var category: Category
    var contacts: [Contact]
    
    static func fetch() -> [PhoneBook] {
        return [
            .init(category: .family, contacts: [
                .init(name: "Mom", phone: "093241232"),
                .init(name: "Dad", phone: "093453234")
            ]),
            .init(category: .friend, contacts: [
                .init(name: "Thet Naing Oo", phone: "0931493224"),
                .init(name: "Su Latt Nwe", phone: "0942341213"),
                .init(name: "Min Thar Si", phone: "093421233"),
                .init(name: "Myo Min Oo", phone: "0933212342"),
                .init(name: "Nain Min Khant", phone: "099982142"),
                .init(name: "Thuzar Nwe", phone: "092134312")
            ]),
            .init(category: .work, contacts: [
                .init(name: "Kooky Boss", phone: "093241224"),
                .init(name: "Cheesy PM", phone: "09843532"),
                .init(name: "Witty PD", phone: "0923495325")
            ])
        ]
    }
    
    enum Category: String {
        case family = "🏠 Family"
        case friend = "🙋🏻 Friends"
        case work = "💼 Work"
    }

}
