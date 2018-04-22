//
//  MovieController.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

class MovieController {

    /// list of all movies 
    var movies = [Movie]()

    /// Last page of movie list
    var currentPagination = 1

    private let service = MovieService()

    // MARK:
    // MARK: Fetch

    /// fetch more popular movies
    /// this method also updates `movie` and `currentPagination` property
    ///
    /// - Parameter completion: result of request
    func fetchMorePopularMovies(_ completion: @escaping (Result<[Movie]>) -> Void) {
        // fetch next page
        service.popular(at: currentPagination + 1) { result in
            switch result {
            case .success(let response):
                // update class
                self.movies.append(contentsOf: response.movies)
                self.currentPagination = response.page

                completion(Result<[Movie]>.success(response.movies))
            case .failed(let error):
                completion(Result<[Movie]>.failed(error))
            }
        }
    }
}
