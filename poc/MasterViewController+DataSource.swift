//
//  MasterViewController+DataSource.swift
//  poc
//
//  Created by Shams Ahmed on 23/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation
import UIKit

extension MasterViewController {

    // MARK:
    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // start fetching next row
        if indexPath.row + 1 == movieController.movies.count {
            fetchMovies()
        }

        // insert image to UI
        fetchImages([indexPath], cell: cell as? MovieCell)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: MovieCell.self),
            for: indexPath
        ) as! MovieCell

        let movie = movieController.movies[indexPath.row]

        cell.configure(
            title: movie.title,
            releaseDate: movie.releaseDate,
            overview: movie.overview,
            score: movie.voteAverage)

        return cell
    }
}
