//
//  MasterViewController.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    /// movie ontroller
    let movieController = MovieController()

    /// configuration controller
    let configurationController = ConfigurationController()

    /// image controller
    lazy var imageController = { return ImageController(configuration: configurationController) }()

    // MARK:
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        title = "Popular Movie"

        super.viewWillAppear(animated)
    }

    // MARK:
    // MARK: Setup

    private func setup() {
        // To interact with the Movie-db you must fetch the configuration
        // if you want to display images
        configurationController.fetchConfiguration { [weak self] in
            switch $0 {
            case .success: self?.fetchMovies()
            case .failed: break // display error to user
            }
        }
    }

    private func setupUI() {
        tableView.prefetchDataSource = self

        // register custom cell
        tableView.register(
            UINib(nibName: String(describing: MovieCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: MovieCell.self)
        )
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

            // pre-fetch images
            imageController.image(
                .low,
                for: movie.posterPath, { [weak cell] result in
                    // if a cell been provided add the image
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
        // would of been nicer to move into a flow coordinators pattern
        // but since it's only a 2 screen pop put focus elsewhere

        let controller = (segue.destination as? UINavigationController)?.topViewController as? DetailViewController

        controller?.imageController = imageController
        controller?.model = sender as? Movie

        title = " "
    }
}
