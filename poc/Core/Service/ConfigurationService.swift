//
//  ConfigurationService.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

struct ConfigurationService {

    /// json decoder
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return decoder
    }()

    // MARK:
    // MARK: Configuration


    /// fetch configuration
    ///
    /// - Parameter completion: result
    func configuration(_ completion: @escaping (Result<Configuration>) -> Void) {
        // build request
        guard let request = ConfigurationRouter.configuration(APIKey: Constants.API.key).url else {
            return completion(
                Result<Configuration>.failed(HTTPSessionManager.Errors.requestCannotBeConstructed)
            )
        }

        /// download image data
        HTTPSessionManager.dataTask(for: request) {
            // process response or pass error
            switch $0 {
            case .success(let data):
                do {
                    // convert data to model
                    let model = try self.decoder.decode(Configuration.self, from: data)

                    completion(Result<Configuration>.success(model))
                } catch {
                    completion(Result<Configuration>.failed(error))
                }
            case .failed(let error):
                completion(Result<Configuration>.failed(error))
            }
        }.resume()
    }
}
