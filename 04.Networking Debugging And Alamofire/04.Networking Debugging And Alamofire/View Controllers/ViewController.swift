//
//  ViewController.swift
//  04.Networking Debugging And Alamofire
//
//  Created by Ko Kyaw on 20/06/2021.
//

import UIKit

enum MovieError: Error {
    case emptyData
    case invalidResponse
    case failedToDecode
}

class ViewController: UIViewController {

    let apiKey = ProcessInfo.processInfo.environment["API_KEY"]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUpcomingMovies { result in
            do {
                let movies = try result.get()
                movies.forEach { print($0) }
            } catch {
            }
        }
    }
    
    private func fetchUpcomingMovies(completion: @escaping (Result<[MovieResult], MovieError>) -> Void) {
        let url = URL(string: "\(baseURL)/movie/upcoming?api_key=\(apiKey)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            
            if error != nil { return }
            
            guard (200..<300).contains((response as! HTTPURLResponse).statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            let movieList = try? JSONDecoder().decode(UpcomingMovieList.self, from: data)
            guard let movies = movieList?.results else {
                completion(.failure(.failedToDecode))
                return
            }
            
            completion(.success(movies))
            
        }.resume()
    }
}

