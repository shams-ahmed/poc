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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: MovieCell.self),
            for: indexPath
        ) as! MovieCell

        let movie = movieController.movies[indexPath.row]

        // style cell
        cell.configure(
            title: movie.title,
            releaseDate: movie.releaseDate,
            overview: movie.overview,
            score: movie.voteAverage)

        return cell
    }
}
