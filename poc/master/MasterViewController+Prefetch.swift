//
//  MasterViewController+Prefetch.swift
//  poc
//
//  Created by Shams Ahmed on 23/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation
import UIKit

extension MasterViewController: UITableViewDataSourcePrefetching {

    // MARK:
    // MARK: UITableViewDataSourcePrefetching

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        fetchImages(indexPaths)
    }
}
