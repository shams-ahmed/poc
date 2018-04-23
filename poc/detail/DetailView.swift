//
//  DetailView.swift
//  poc
//
//  Created by Shams Ahmed on 23/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation
import UIKit

class DetailView: UIView {

    @IBOutlet private var imageView: UIImageView!

    // MARK:
    // MARK: Configure

    /// Add image to view
    ///
    /// - Parameter image: image
    func addImage(_ image: UIImage) {
        imageView.image = image
    }
}
