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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = movieController.movies[indexPath.row]

        /// show image
        performSegue(withIdentifier: "showDetail", sender: model)

        // deselect row
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
