//
//  MDBEndPoint.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 17/08/2021.
//

import Alamofire

enum MDBEndPoint: URLConvertible, URLRequestConvertible {

    case upComingMovies
    case popularMovies
    case popularSeries
    case showcaseMovies(pageNo: Int = 1)
    case searchMovies(keyword: String)
    case movieDetail(id: Int, contentType: MovieFetchType)
    case moviesOfAnActor(actorId: Int)
    case movieTrailer(movieId: Int, contentType: MovieFetchType)
    case similarMovies(movieId: Int, contentType: MovieFetchType)
    case genres
    case allActors(pageNo: Int = 1)
    case actorsOfAMovie(movieId: Int, contentType: MovieFetchType)
    case actorDetail(actorId: Int)
    
    func asURL() throws -> URL {
        return URL(string: urlString)!
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: try asURL())
        request.cachePolicy = .reloadIgnoringCacheData
        return request
    }
    
    var urlString: String {
        get {
            switch self {
            case .upComingMovies:
                return "\(baseURL)/movie/upcoming?api_key=\(apiKey)"
            case .popularMovies:
                return "\(baseURL)/movie/popular?api_key=\(apiKey)"
            case .popularSeries:
                return "\(baseURL)/tv/popular?api_key=\(apiKey)"
            case .showcaseMovies(let pageNo):
                return "\(baseURL)/movie/top_rated?api_key=\(apiKey)&page=\(pageNo)"
            case .searchMovies(let keyword):
                return "\(baseURL)/search/movie/?api_key=\(apiKey)&query=\(keyword)"
            case .movieDetail(let id, let type):
                return "\(baseURL)/\(type.rawValue)/\(id)?api_key=\(apiKey)"
            case .moviesOfAnActor(let id):
                return "\(baseURL)/person/\(id)/combined_credits?api_key=\(apiKey)"
            case .genres:
                return "\(baseURL)/genre/movie/list?api_key=\(apiKey)"
            case .actorsOfAMovie(let id, let type):
                return "\(baseURL)/\(type.rawValue)/\(id)/credits?api_key=\(apiKey)"
            case .movieTrailer(let id, let type):
                return "\(baseURL)/\(type.rawValue)/\(id)/videos?api_key=\(apiKey)"
            case .similarMovies(let id, let type):
                return "\(baseURL)/\(type.rawValue)/\(id)/recommendations?api_key=\(apiKey)"
            case .actorDetail(let id):
                return "\(baseURL)/person/\(id)?api_key=\(apiKey)"
            case .allActors(let pageNo):
                return "\(baseURL)/person/popular/?api_key=\(apiKey)&page=\(pageNo)"
            }
        }
    }
    
}
