//
//  APIManager.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import Foundation
struct APIManager {
    ///API key required for server communications
    static private var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String else {
            fatalError("API key not found")
        }
        return key
    }
    /// API base url
    static private var baseURL: String {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "ServerURL") as? String else {
            fatalError("Base url not found")
        }
        return baseURL
    }
    
    static private var imageURL: String {
        guard let imageURL = Bundle.main.object(forInfoDictionaryKey: "ImageURL") as? String else {
            fatalError("Image url not found")
        }
        return imageURL
    }
    
    
    /// Generate endpoint for request
    enum EndPoint {
        ///Get a list of movies
        case MovieList(pageNumber:Int)
        case PosterImage(imageName:String)
        case MovieDetails(id:Int)
        case LogoImage(imageName:String)
        case SimilarMovieDetails(id:Int, pageNumber:Int)
        case MovieCreditsDetails(id:Int)
        case MovieReviewsDetails(id:Int)
        /// Generate request data based on request endpoint
        /// - Parameter endPoint: endpoint
        /// - Returns: Request model
        static func generateRequest(for endPoint: EndPoint) -> RequestModel {
            var requestURL = APIManager.baseURL
            switch endPoint {
            case .MovieList(let pageNumber):
                requestURL.append("movie/now_playing?api_key=")
                requestURL.append(APIManager.apiKey)
                requestURL.append("&language=en-US")
                requestURL.append("&page=\(pageNumber)")
                let request = RequestModel(url: requestURL)
                return request
            case .PosterImage(let imageName):
                var imageURL = APIManager.imageURL
                imageURL.append(contentsOf: "t/p/w185/\(imageName)")
                let request = RequestModel(url: imageURL)
                return request
            case .MovieDetails(let id):
                requestURL.append("movie/\(id)?api_key=")
                requestURL.append(APIManager.apiKey)
                requestURL.append("&language=en-US")
                let request = RequestModel(url: requestURL)
                return request
            case .SimilarMovieDetails(let id, let pageNumber):
                requestURL.append("movie/\(id)/similar?api_key=")
                requestURL.append(APIManager.apiKey)
                requestURL.append("&language=en-US")
                requestURL.append("&page=\(pageNumber)")
                let request = RequestModel(url: requestURL)
                return request
            case .LogoImage(let imageName):
                var imageURL = APIManager.imageURL
                imageURL.append(contentsOf: "t/p/w154/\(imageName)")
                let request = RequestModel(url: imageURL)
                return request
            case .MovieCreditsDetails(let id):
                requestURL.append("movie/\(id)/credits?api_key=")
                requestURL.append(APIManager.apiKey)
                let request = RequestModel(url: requestURL)
                return request
            case .MovieReviewsDetails(let id):
                requestURL.append("movie/\(id)/reviews?api_key=")
                requestURL.append(APIManager.apiKey)
                let request = RequestModel(url: requestURL)
                requestURL.append("&language=en-US")
                requestURL.append("&page=1")
                return request
            }
        }
    }
}
