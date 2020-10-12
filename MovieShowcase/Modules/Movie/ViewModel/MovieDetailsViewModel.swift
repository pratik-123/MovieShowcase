//
//  MovieDetailsViewModel.swift
//  MovieShowcase
//
//  Created by Pratik on 11/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import Foundation
enum MovieDetailsType {
    case ProductionCompanies
    case SimilarMovie
    case MovieCredit
    case MovieReview
}
final class MovieDetailsViewModel {
    var objMovie: MovieListModel?
    weak var service: MovieDetailsServiceProtocol?
    var onRefreshHandling : ((_ type: MovieDetailsType) -> Void)?
    var onErrorHandling : ((ErrorResult?) -> Void)?
    var movieModel: MovieListBaseModel?
    var arrayOfMoveiList = [MovieListModel]()
    var movieCredit: MovieCreditBaseModel?
    var arrayOfReviews = [Review]()

    init(movie: MovieListModel, service: MovieDetailsServiceProtocol = MovieDetailsService.shared) {
        self.objMovie = movie
        self.service = service
    }
    
    /// Movie details data get
    func getMovieDetailsData() {
        service?.fetchMovieDetails(id: objMovie?.id ?? 0, completion: { (result) in
            switch result {
            case .success(let baseModel):
                self.objMovie = baseModel
                self.onRefreshHandling?(.ProductionCompanies)
                break
            case .failure(let error):
                print(error)
                self.onErrorHandling?(ErrorResult.network(string: error.localizedDescription))
                break
            }
        })
    }
    
    func getSimilarMovieDetailsData() {
        var pageNumber = 1
        ///check page number with total number of page
        if let obj = movieModel, obj.page != obj.total_pages {
            pageNumber = obj.page ?? pageNumber
            pageNumber += 1
        }
        service?.fetchSimilarMovieDetails(id: objMovie?.id ?? 0, pageNumber: pageNumber, completion: { (result) in
            switch result {
            case .success(let baseModel):
                self.movieModel = baseModel
                if let array = baseModel.movieLists {
                    self.arrayOfMoveiList.append(contentsOf: array)
                }
                self.onRefreshHandling?(.SimilarMovie)
                break
            case .failure(let error):
                print(error)
                self.onErrorHandling?(ErrorResult.network(string: error.localizedDescription))
                break
            }
        })
    }
    func getMovieCreditsDetailsData() {
        service?.fetchCreditsDetails(id: objMovie?.id ?? 0, completion: { (result) in
            switch result {
            case .success(let baseModel):
                self.movieCredit = baseModel
                self.onRefreshHandling?(.MovieCredit)
                break
            case .failure(let error):
                print(error)
                self.onErrorHandling?(ErrorResult.network(string: error.localizedDescription))
                break
            }
        })
    }
    func getMovieReviewDetailsData() {
        service?.fetchReviewsDetails(id: objMovie?.id ?? 0, completion: { (result) in
            switch result {
            case .success(let baseModel):
                self.arrayOfReviews = baseModel.results ?? []
                self.onRefreshHandling?(.MovieReview)
                break
            case .failure(let error):
                print(error)
                self.onErrorHandling?(ErrorResult.network(string: error.localizedDescription))
                break
            }
        })
    }
}
extension MovieDetailsViewModel {
    /// company count return
    func numberOfCompanies() -> Int {
        return objMovie?.productionCompnies?.count ?? 0
    }
    
    /// company object return based on index
    func company(at index: Int) -> ProductionCompanies? {
        let compnies = objMovie?.productionCompnies ?? []
        if compnies.indices.contains(index) {
            return compnies[index]
        }
        return nil
    }
}
extension MovieDetailsViewModel {
    /// similar movie count return
    func numberOfSimilarMovie() -> Int {
        return arrayOfMoveiList.count
    }
    
    /// similar movie object return based on index
    func similarMovie(at index: Int) -> MovieListModel? {
        if arrayOfMoveiList.indices.contains(index) {
            return arrayOfMoveiList[index]
        }
        return nil
    }
}
extension MovieDetailsViewModel {
    func numberOfReviews() -> Int {
        return arrayOfReviews.count
    }
    
    func movieReview(at index: Int) -> Review? {
        if arrayOfReviews.indices.contains(index) {
            return arrayOfReviews[index]
        }
        return nil
    }
}
