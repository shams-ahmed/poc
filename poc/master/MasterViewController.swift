//
//  MasterViewController.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    let movieController = MovieController()
    let configurationController = ConfigurationController()

    lazy var imageController = { return ImageController(configuration: configurationController) }()

    // MARK:
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        title = "Popular Movie"

        super.viewWillAppear(animated)
    }

    // MARK:
    // MARK: Setup

    private func setup() {
        tableView.prefetchDataSource = self

        tableView.register(
            UINib(nibName: String(describing: MovieCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: MovieCell.self)
        )

        configurationController.fetchConfiguration { [weak self] in
            switch $0 {
            case .success: self?.fetchMovies()
            case .failed: break // display error to user
            }
        }
    }

    // MARK:
    // MARK: Fetching

    func fetchMovies() {
        movieController.fetchMorePopularMovies { [weak tableView] _ in
            DispatchQueue.main.async { tableView?.reloadData() }
        }
    }

    func fetchImages(_ indexPaths: [IndexPath], cell: MovieCell?=nil) {
        indexPaths.forEach {
            let movie = movieController.movies[$0.row]

            imageController.image(
                .low,
                for: movie.posterPath, { [weak cell] result in
                    guard let cell = cell else { return }

                    DispatchQueue.main.async {
                        switch result {
                        case .success(let image): cell.addImage(image)
                        case .failed: break // display no error placeholder
                        }
                    }
            })
        }
    }

    // MARK:
    // MARK: Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = (segue.destination as? UINavigationController)?.topViewController as? DetailViewController

        controller?.imageController = imageController
        controller?.model = sender as? Movie

        controller?.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller?.navigationItem.leftItemsSupplementBackButton = true

        title = " "
    }
}
