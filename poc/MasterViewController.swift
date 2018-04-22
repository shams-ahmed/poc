//
//  MasterViewController.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil

    let movieController = MovieController()
    let configurationController = ConfigurationController()

    lazy var imageController = {
        return ImageController(configuration: configurationController)
    }()

    // MARK:
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK:
    // MARK: Setup

    private func setup() {
        configurationController.fetchConfiguration { 
            switch $0 {
            case .success: self.fetchMovies()
            case .failed: break // display error to user
            }
        }
    }

    private func fetchMovies() {
        self.movieController.fetchMorePopularMovies { _ in
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }

    // MARK:
    // MARK: Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController

                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK:
    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // start fetching next row
        if indexPath.row + 1 == movieController.movies.count {
            fetchMovies()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = movieController.movies[indexPath.row]

        cell.textLabel?.text = object.title

        return cell
    }
}
