//
//  MovieListModel.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import Foundation
struct MovieListBaseModel : Codable {
    let movieLists : [MovieListModel]?
    let page : Int?
    let total_results : Int?
    let total_pages : Int?

    enum CodingKeys: String, CodingKey {
        case movieLists = "results"
        case page = "page"
        case total_results = "total_results"
        case total_pages = "total_pages"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movieLists = try values.decodeIfPresent([MovieListModel].self, forKey: .movieLists)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
    }

}
struct MovieListModel : Codable {
    let id : Int?
    let poster_path : String?
    let backdrop_path : String?
    let original_title : String?
    let title : String?
    let overview : String?
    let release_date : String?
    let productionCompnies: [ProductionCompanies]?

    var displayDate : String? {
        get {
            let date = release_date?.dateFormateChange(currentDateFormate: .ServerFormate)
            return date
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case poster_path = "poster_path"
        case id = "id"
        case backdrop_path = "backdrop_path"
        case original_title = "original_title"
        case title = "title"
        case overview = "overview"
        case release_date = "release_date"
        case productionCompnies = "production_companies"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
        productionCompnies = try values.decodeIfPresent([ProductionCompanies].self, forKey: .productionCompnies)
    }
}
struct ProductionCompanies : Codable {
    let id : Int?
    let logo_path : String?
    let name : String?
    let origin_country : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case logo_path = "logo_path"
        case name = "name"
        case origin_country = "origin_country"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        logo_path = try values.decodeIfPresent(String.self, forKey: .logo_path)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        origin_country = try values.decodeIfPresent(String.self, forKey: .origin_country)
    }

}
