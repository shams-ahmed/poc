//
//  MovieCell.swift
//  poc
//
//  Created by Shams Ahmed on 23/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {

    // MARK:
    // MARK: typealias

    private typealias Score = (text: NSAttributedString, color: UIColor)

    @IBOutlet private var poster: UIImageView!
    @IBOutlet private var title: UILabel!
    @IBOutlet private var releaseDate: UILabel!
    @IBOutlet private var overview: UILabel!
    @IBOutlet private var score: UILabel!

    // MARK:
    // MARK: Nib

    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    // MARK:
    // MARK: Setup

    private func setup() {
        score.font = UIFont.boldSystemFont(ofSize: 16)
    }

    // MARK:
    // MARK: Configure

    // Configure cell for current nad next view
    func configure(
        poster: UIImage?=nil,
        title: String,
        releaseDate: Date,
        overview: String,
        score: Double) {
        let formattedScore = scoreBuilder(score)

        self.poster.image = poster
        self.title.text = title
        self.releaseDate.text = DateFormatter.mmmmDyyyy.string(from: releaseDate)
        self.overview.text = overview
        self.score.attributedText = formattedScore.text
        self.score.textColor = formattedScore.color
    }

    // Add image to view
    func addImage(_ image: UIImage) {
        poster.image = image
    }

    // MARK:
    // MARK: Private - Helper

    private func scoreBuilder(_ score: Double) -> Score {
        let percentage = Int(score * 100 / 10)
        let text = NSAttributedString(string: String(percentage) + "﹪")
        let color: UIColor

        if percentage >= 70 {
            color = UIColor(red: 167/255, green: 212/255, blue: 90/255, alpha: 1)
        } else if percentage >= 40 {
            color = UIColor(red: 236/255, green: 174/255, blue: 107/255, alpha: 1)
        } else {
            color = .red
        }

        return Score(text: text, color: color)
    }
}
