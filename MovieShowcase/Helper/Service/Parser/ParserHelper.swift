//
//  ParserHelper.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import CoreData
protocol Parseable {
    func parse<T: Decodable>(_ type: T.Type, from data: Data, completion: @escaping (Result<T, ErrorResult>) -> Void)
}

extension Parseable {
    /// Parsable data with model using codable protocol
    /// - Parameters:
    ///   - type: class type generic
    ///   - data: data
    ///   - completion: completion handler
    func parse<T: Decodable>(_ type: T.Type, from data: Data, completion: @escaping (Result<T, ErrorResult>) -> Void) {
        
        let jsonDecorder = JSONDecoder()
        do {
            let parseObject = try jsonDecorder.decode(type.self, from: data)
            completion(.success(parseObject))
        } catch {
            print(error)
            completion(.failure(.parser(string: error.localizedDescription)))
        }
    }
}
