//
//  MovieService.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

struct MovieService {

    /// json decoder
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)

        return decoder
    }()

    // MARK:
    // MARK: Popular

    /// Fetch popular movie by page numbe
    ///
    /// - Parameters:
    ///   - page: page to fetch
    ///   - completion: result of request
    func popular(at page: Int, _ completion: @escaping (Result<MovieResponse>) -> Void) {
        /// build request
        guard let request = MovieRouter.popular(
            APIKey: Constants.API.key,
            page: page).url else {
            return completion(
                Result<MovieResponse>.failed(HTTPSessionManager.Errors.requestCannotBeConstructed)
            )
        }

        /// start fetch
        HTTPSessionManager.dataTask(for: request) {
            // process response or pass error
            switch $0 {
            case .success(let data):
                do {
                    // convert data to models
                    let model = try self.decoder.decode(MovieResponse.self, from: data)

                    completion(Result<MovieResponse>.success(model))
                } catch {
                    completion(Result<MovieResponse>.failed(error))
                }
            case .failed(let error):
                // leaving here, ideally something could be done here to retry request
                // if it a certain status code before reporting error
                completion(Result<MovieResponse>.failed(error))
            }

        }.resume()
    }
}
