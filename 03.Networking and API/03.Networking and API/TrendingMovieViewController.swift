//
//  TrendingMovieViewController.swift
//  03.Networking and API
//
//  Created by Ko Kyaw on 13/06/2021.
//

import UIKit

class TrendingMovieViewController: UITableViewController {
    
    var movies = [Movie]()
    let cache = NSCache<NSString, UIImage>()
    var currentImageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        async {
            do {
                let results = try await fetchTrendingMovies()
                movies.append(contentsOf: results)
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func fetchTrendingMovies() async throws -> [Movie] {
        let url = URL(string: "\(baseURL)/trending/movie/week?api_key=\(apiKey)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
                  throw TrendingMovieError.invalidResponse(message: "Failed with status \((response as! HTTPURLResponse).statusCode)")
            }
        
        let contentType = httpResponse.value(forHTTPHeaderField: "Content-Type")!
        if !contentType.contains("application/json") {
            throw TrendingMovieError.invalidContentType(message: "Expected json content but found \(contentType)")
        }
        
        let decoder = JSONDecoder()
        do {
            let movies = try decoder.decode(MovieResult.self, from: data).movies
            return movies
        } catch {
            throw TrendingMovieError.decodingError(message: "Failed to decode into [Movie] from give data. ERROR: \(error.localizedDescription)")
        }
    }
    
    private func downloadImage(from urlString: String) async throws -> UIImage {
        let cacheImage = try await UIImage.downloaded(from: urlString)
        
        guard let cacheImage = cacheImage else {
            return UIImage()
        }

        if let image = cache.object(forKey: NSString(string: urlString)) {
            return image
        }
        
        cache.setObject(cacheImage, forKey: NSString(string: urlString))
        return cacheImage
    }
    
}

extension TrendingMovieViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let movie = movies[indexPath.item]
        
        var imageTask: [IndexPath: Task.Handle<Void, Never>] = [:]
        
        currentImageURL = movie.posterPath!
        
        cell.textLabel?.text = movie.name
        cell.detailTextLabel?.text = movie.releaseDate
        
        imageTask[indexPath] = async {
            let image = try? await downloadImage(from: movie.posterPath!)
            if self.currentImageURL == movie.posterPath! {
                cell.imageView?.image = image
            }
        }
        
        return cell
    }
}
