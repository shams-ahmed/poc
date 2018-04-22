//
//  ImageController.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation
import UIKit

class ImageController {

    // MARK:
    // MARK: Enum

    enum Errors: Error {
        case configurationError
    }

    /// Image quality
    ///
    /// - low: image with smallest size returned in poster_size i.e thumbnail
    /// - high: image will the best resolution returned in poster_size
    enum Quality {
        /// image with smallest size i.e thumbnail
        case low
        /// image will the best resolution
        case high
    }

    private let service = ImageService()

    /// configuration with DI
    let configurationController: ConfigurationController

    // MARK:
    // MARK: Initializers I

    init(configuration: ConfigurationController) {
        configurationController = configuration
    }

    // MARK:
    // MARK: Image

    /// download image at path
    ///
    /// - Parameters:
    ///   - quality: see enum
    ///   - path: path of image
    ///   - completion: result
    func image(_ quality: Quality, for path: String, _ completion: @escaping (Result<UIImage>) -> Void) {
        guard let configuration = configurationController.configuration else {
            return completion(Result<UIImage>.failed(Errors.configurationError))
        }

        // the API send the sizes in order i.e lowest size as the first string in array
        guard let size: String = ({
            switch quality {
            case .high: return configuration.posterSizes.last
            case .low: return configuration.posterSizes.first
            }
        })() else {
            return completion(Result<UIImage>.failed(Errors.configurationError))
        }

        // start download
        service.download(path: path, size: size) {
            switch $0 {
            case .success(let data):
                // convert to native object
                guard let image = UIImage(data: data) else {
                    return completion(Result<UIImage>.failed(
                        HTTPSessionManager.Errors.invalidResponse)
                    )
                }

                completion(Result<UIImage>.success(image))
            case .failed(let error):
                completion(Result<UIImage>.failed(error))
            }
        }
    }
}
