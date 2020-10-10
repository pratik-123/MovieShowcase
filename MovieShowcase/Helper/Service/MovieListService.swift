//
//  MovieListService.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import Foundation

/// Movie list helper methods
protocol MovieListServiceProtocol: class {
    func fetchMovieList(pageNumber : Int, completion: @escaping ((Result<MovieListBaseModel, ErrorResult>) -> Void))
}
final class MovieListService: Parseable, MovieListServiceProtocol {
    static let shared = MovieListService()
    
    /// Fetch movie list data
    /// - Parameters:
    ///   - pageNumber: page number
    func fetchMovieList(pageNumber : Int, completion: @escaping ((Result<MovieListBaseModel, ErrorResult>) -> Void)) {
        let endPoint = APIManager.EndPoint.MovieList(pageNumber: pageNumber)
        let requestData = APIManager.EndPoint.generateRequest(for: endPoint)
        ServerCommunication.shared.dataTask(requestObject: requestData) { (response) in
            guard let data = response?.data else {
                completion(.failure(.custom(string: response?.error.debugDescription ?? "Data not found")))
                return
            }
            self.parse(MovieListBaseModel.self, from: data, completion: completion)
        }
    }
}
