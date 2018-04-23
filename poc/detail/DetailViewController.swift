//
//  DetailViewController.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import UIKit

/// Image view
class DetailViewController: UIViewController, CustomView {

    /// Custom view
    lazy var getView: DetailView = {
        guard let view = view as? DetailView else {
            fatalError("view has not been set in storyboard")
        }

        return view
    }()

    /// Image controller
    var imageController: ImageController?

    /// Model
    var model: Movie?

    // MARK:
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK:
    // MARK: Setup

    private func setup() {
        guard let model = model else {
            // internal checks
            assertionFailure("`DetailViewController` was not setup correctly")

            return
        }

        // set image
        imageController?.image(.high, for: model.posterPath, { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image): self?.getView.addImage(image)
                case .failed: break // display alert
                }
            }
        })

        // set title
        title = model.title
    }
}
