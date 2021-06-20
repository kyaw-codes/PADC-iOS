//
//  ConcurrencyDemoViewController.swift
//  03.Networking and API
//
//  Created by Ko Kyaw on 12/06/2021.
//

import UIKit

class ConcurrencyDemoViewController: UIViewController {

    var numbers: [Int]? {
        didSet {
            guard let numbers = numbers else {
                return
            }
            print("Numbers are: \(numbers)")
        }
    }
    
    var average: Double? {
        didSet {
            guard let average = average else {
                return
            }
            print("Average is: \(average)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        async {
            let numbers = await getRandomNumbers(after: 3)
            self.numbers = numbers

            let average = await average(of: numbers)
            self.average = average
        }

        print("Operating...")
    }
    
    func getRandomNumbers(after delay: TimeInterval) async -> [Int] {
        Thread.sleep(forTimeInterval: delay)
        return (1...10).map { _ in Int.random(in: 1...20)}
    }
    
    func average(of numbers: [Int]) async -> Double {
        Thread.sleep(forTimeInterval: 2)
        let totlal = numbers.reduce(0, +)
        
        return Double(totlal / numbers.count)
    }
}
