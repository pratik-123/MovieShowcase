//
//  MovieDetailsService.swift
//  MovieShowcase
//
//  Created by Pratik on 11/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import Foundation

/// Movie details helper methods
protocol MovieDetailsServiceProtocol: class {
    func fetchMovieDetails(id: Int, completion: @escaping ((Result<MovieListModel, ErrorResult>) -> Void))
    func fetchSimilarMovieDetails(id: Int, pageNumber: Int, completion: @escaping ((Result<MovieListBaseModel, ErrorResult>) -> Void))
    func fetchCreditsDetails(id: Int, completion: @escaping ((Result<MovieCreditBaseModel, ErrorResult>) -> Void))
    func fetchReviewsDetails(id: Int, completion: @escaping ((Result<MovieReviewDetailsBaseModel, ErrorResult>) -> Void))
}
final class MovieDetailsService: Parseable, MovieDetailsServiceProtocol {
    static let shared = MovieDetailsService()
    
    /// Fetch movie details data
    /// - Parameters:
    ///   - id: movie id
    func fetchMovieDetails(id: Int, completion: @escaping ((Result<MovieListModel, ErrorResult>) -> Void)) {
        let endPoint = APIManager.EndPoint.MovieDetails(id: id)
        let requestData = APIManager.EndPoint.generateRequest(for: endPoint)
        ServerCommunication.shared.dataTask(requestObject: requestData) { (response) in
            guard let data = response?.data else {
                completion(.failure(.custom(string: response?.error.debugDescription ?? "Data not found")))
                return
            }
            self.parse(MovieListModel.self, from: data, completion: completion)
        }
    }
    
    func fetchSimilarMovieDetails(id: Int, pageNumber: Int, completion: @escaping ((Result<MovieListBaseModel, ErrorResult>) -> Void)) {
        let endPoint = APIManager.EndPoint.SimilarMovieDetails(id: id, pageNumber: pageNumber)
        let requestData = APIManager.EndPoint.generateRequest(for: endPoint)
        ServerCommunication.shared.dataTask(requestObject: requestData) { (response) in
            guard let data = response?.data else {
                completion(.failure(.custom(string: response?.error.debugDescription ?? "Data not found")))
                return
            }
            self.parse(MovieListBaseModel.self, from: data, completion: completion)
        }
    }
    
    func fetchCreditsDetails(id: Int, completion: @escaping ((Result<MovieCreditBaseModel, ErrorResult>) -> Void)) {
        let endPoint = APIManager.EndPoint.MovieCreditsDetails(id: id)
        let requestData = APIManager.EndPoint.generateRequest(for: endPoint)
        ServerCommunication.shared.dataTask(requestObject: requestData) { (response) in
            guard let data = response?.data else {
                completion(.failure(.custom(string: response?.error.debugDescription ?? "Data not found")))
                return
            }
            self.parse(MovieCreditBaseModel.self, from: data, completion: completion)
        }
    }
    func fetchReviewsDetails(id: Int, completion: @escaping ((Result<MovieReviewDetailsBaseModel, ErrorResult>) -> Void)) {
        let endPoint = APIManager.EndPoint.MovieReviewsDetails(id: id)
        let requestData = APIManager.EndPoint.generateRequest(for: endPoint)
        ServerCommunication.shared.dataTask(requestObject: requestData) { (response) in
            guard let data = response?.data else {
                completion(.failure(.custom(string: response?.error.debugDescription ?? "Data not found")))
                return
            }
            self.parse(MovieReviewDetailsBaseModel.self, from: data, completion: completion)
        }
    }
}
