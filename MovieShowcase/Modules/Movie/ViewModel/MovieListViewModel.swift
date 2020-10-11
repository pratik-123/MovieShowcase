//
//  MovieListViewModel.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import Foundation

final class MovieListViewModel {
    weak var service: MovieListServiceProtocol?
    var movieListBaseModel: MovieListBaseModel?
    var onRefreshHandling : (() -> Void)?
    var onErrorHandling : ((ErrorResult?) -> Void)?
    var arrayOfMoveiList = [MovieListModel]()

    
    init(service: MovieListServiceProtocol = MovieListService.shared) {
        self.service = service
    }
    
    /// Movie list data get
    func getMovieListData() {
        var pageNumber = 1
        ///check page number with total number of page
        if let obj = movieListBaseModel, obj.page != obj.total_pages {
            pageNumber = obj.page ?? pageNumber
            pageNumber += 1
        }
        service?.fetchMovieList(pageNumber: pageNumber, completion: { (result) in
            switch result {
            case .success(let baseModel):
                self.movieListBaseModel = baseModel
                if let array = baseModel.movieLists {
                    self.arrayOfMoveiList.append(contentsOf: array)
                }
                self.onRefreshHandling?()
                break
            case .failure(let error):
                print(error)
                self.onErrorHandling?(ErrorResult.network(string: error.localizedDescription))
                break
            }
        })
    }
}
extension MovieListViewModel {
    
    /// movie count return
    func numberOfMovies() -> Int {
        return arrayOfMoveiList.count
    }
    
    /// Movie object found based on index
    /// - Parameter index: index
    /// - Returns: movei object
    func movie(at index: Int) -> MovieListModel? {
        if arrayOfMoveiList.indices.contains(index) {
            return arrayOfMoveiList[index]
        }
        return nil
    }
}
