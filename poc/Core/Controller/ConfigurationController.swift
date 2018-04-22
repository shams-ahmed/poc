//
//  ConfigurationController.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

class ConfigurationController {

    private let service = ConfigurationService()

    /// Current configuration
    var configuration: Configuration?

    // MARK:
    // MARK: Fetch

    /// Fetch new configuration and set constants
    ///
    /// - Parameter completion: results
    func fetchConfiguration(_ completion: @escaping (Result<Void>) -> Void) {
        service.configuration {
            switch $0 {
            case .success(let configuration):
                self.configuration = configuration
                Constants.API.imageUrl = configuration.imageBaseURL

                completion(Result<Void>.success(()))
            case .failed(let error):
                completion(Result<Void>.failed(error))
            }
        }
    }
}
