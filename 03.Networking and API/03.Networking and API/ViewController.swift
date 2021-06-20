//
//  ViewController.swift
//  03.Networking and API
//
//  Created by Ko Kyaw on 12/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "7938a76e19837644a4d77bf6fbf3a966"
    private lazy var genreListURL = URL(string: "\(baseURL)/genre/movie/list?api_key=\(apiKey)")!
    private lazy var loginURL = URL(string: "\(baseURL)/authentication/token/validate_with_login?api_key=\(apiKey)")!
    
    typealias GenreList = [[String : Any]]

    override func viewDidLoad() {
        super.viewDidLoad()

        let username = ProcessInfo.processInfo.environment["username"]!
        let password = ProcessInfo.processInfo.environment["password"]!
        let token = ProcessInfo.processInfo.environment["request_token"]!
        
        async {
            do {
                let (genre, _) = try await fetchGenre(from: genreListURL)

                let genres = try convertDataWithJsonSerialization(genre)
                genres.forEach { print($0) }

                let loginData = try await login(with: loginURL, username: username, password: password, requestToken: token)

            } catch {
                print("Oops! An error occured: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Networking Methods
    
    private func fetchGenre(from url: URL) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw MovieError.invalidResponse
              }
        
        guard httpResponse.value(forHTTPHeaderField: "Content-Type") == "application/json;charset=utf-8" else {
            throw MovieError.invalidContentType
        }
        
        return (data, httpResponse)
    }
    
    private func fetchGenreWithDelegate(from url: URL) {
        URLSession(configuration: .default, delegate: self, delegateQueue: nil).dataTask(with: url).resume()
    }
    
    private func login(with url: URL, username: String, password: String, requestToken token: String) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginInfo = [
            "username" : username,
            "password" : password,
            "request_token" : token
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: loginInfo, options: .init())
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode) else {
                  throw MovieError.invalidLogin
              }
        return data
    }
    
    // MARK: - Helper Methods
    
    private func convertDataWithJsonSerialization(_ genre: Data) throws -> [MovieGenre] {
        // Convert json data into foundation obj with JSONSerialization
        let dataDict = try JSONSerialization.jsonObject(with: genre, options: .init()) as! [String: Any]
        let genreList = dataDict["genres"] as! GenreList
        
        return genreList.map {
            MovieGenre(id: $0["id"] as! Int, name: $0["name"] as! String)
        }
    }

}

struct MovieGenre {
    let id: Int
    let name: String
}

extension ViewController: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error else { return }
        print("Error:", error)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("Data:", data)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("Response:", response)
    }
}

extension ViewController {
    
    enum MovieError: Error {
        case invalidResponse
        case invalidContentType
        case invalidLogin
    }
}
