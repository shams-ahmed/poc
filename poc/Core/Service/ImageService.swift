//
//  ImageService.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

struct ImageService {

    // MARK:
    // MARK: Download

    /// download image at a given path
    ///
    /// - Parameters:
    ///   - path: path of image
    ///   - size: size of image
    ///   - completion: result
    func download(path: String, size: String, _ completion: @escaping (Result<Data>) -> Void) {
        // build request
        guard var request = ImageRouter.image(
            size: size,
            path: path).url else {
            return completion(
                Result<Data>.failed(HTTPSessionManager.Errors.requestCannotBeConstructed)
            )
        }

        // try speed up request by fetching cache if available
        request.cachePolicy = .returnCacheDataElseLoad

        /// download image data
        HTTPSessionManager.dataTask(for: request) {
            // process response or pass error
            switch $0 {
            case .success(let data):
                completion(Result<Data>.success(data))
            case .failed(let error):
                // leaving here, ideally something could be done here to retry request
                // i.e if it a certain status code before reporting error
                completion(Result<Data>.failed(error))
            }
        }.resume()
    }
}
