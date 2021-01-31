//
//  Basic.swift
//  01.HelloWorld
//
//  Created by Ko Kyaw on 21/01/2021.
//

import Foundation

var colorList: [String] = ["red", "green", "blue"]

var regionList: Set = ["Yangon", "Mandalay", "Nay-pyi-taw"]

var townshipList: [String: [String]] = [
    "Yangon": ["Tamwe", "Tharkayta", "Hledan"]
]

var isEven: (Int) -> Bool = { $0 % 2 == 0 }

func main() {
    
    var color = "olive"
    color = "lemon"
    
    [color, "violet", "brown", "teal"].forEach { colorList.append($0) }
    
    guard let townshipsOfYangon = townshipList["Yangon"] else { return }
    debugPrint(townshipsOfYangon)
    
    for color in colorList {
        debugPrint(color)
    }
    
    var indexForWhile = 0
    while indexForWhile < 3 {
        debugPrint(colorList[indexForWhile])
        indexForWhile += 1
    }
    
    var indexForRepeatWhile = 0
    repeat {
        debugPrint(indexForRepeatWhile)
        indexForRepeatWhile += 1
    } while indexForWhile < 3
    
    debugPrint(isEven(13))
    
    let multiplyNineBy = multiply(9)
    debugPrint(multiplyNineBy(2))
    
    fetchData("https://www.api/products/laptop") { (data) in
        debugPrint(data)
    }
}

func multiply(_ number: Int) -> (Int) -> Int {
    return { number * $0 }
}

func fetchData(_ withUrl: String, onComplete: @escaping ([Any]) -> Void) {
    
    let dummyData = ["Macbook Air", "Macbook Pro", "iMac"]
        
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        onComplete(dummyData)
    }
}
