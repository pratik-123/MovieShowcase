//
//  MovieCreditBaseModel.swift
//  MovieShowcase
//
//  Created by Pratik on 12/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import Foundation
struct MovieCreditBaseModel : Codable {
    let id : Int?
    let cast : [Cast]?
    let crew : [Crew]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
        case crew = "crew"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        cast = try values.decodeIfPresent([Cast].self, forKey: .cast)
        crew = try values.decodeIfPresent([Crew].self, forKey: .crew)
    }

}
struct Cast : Codable {
    let character : String?
    let name : String?
    let profile_path : String?
}
struct Crew : Codable {
    let department : String?
    let job : String?
    let name : String?
    let profile_path : String?
}
