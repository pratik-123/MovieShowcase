//
//  MovieReviewDetailsBaseModel.swift
//  MovieShowcase
//
//  Created by Pratik on 12/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import Foundation
struct MovieReviewDetailsBaseModel : Codable {
    let id : Int?
    let page : Int?
    let results : [Review]?
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([Review].self, forKey: .results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
    }

}
struct Review : Codable {
    let author : String?
    let content : String?
    let id : String?
    let url : String?
}
