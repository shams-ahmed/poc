//
//  MasterViewController+Delegate.swift
//  poc
//
//  Created by Shams Ahmed on 23/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation
import UIKit

extension MasterViewController {

    // MARK:
    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // start fetching next row
        if indexPath.row + 1 == movieController.movies.count {
            fetchMovies()
        }

        // insert image to UI
        fetchImages([indexPath], cell: cell as? MovieCell)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = movieController.movies[indexPath.row]

        /// show image
        performSegue(withIdentifier: "showDetail", sender: model)

        // deselect row
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
