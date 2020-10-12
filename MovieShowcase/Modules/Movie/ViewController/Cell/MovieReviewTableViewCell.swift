//
//  MovieReviewTableViewCell.swift
//  MovieShowcase
//
//  Created by Pratik on 12/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import UIKit

class MovieReviewTableViewCell: UITableViewCell {
    static let identifer = String(describing: MovieReviewTableViewCell.self)
    @IBOutlet weak var labelContent: PLSubTitleLabel!
    @IBOutlet weak var textViewURL: UITextView!
    @IBOutlet weak var labelAuthor: PLSubTitleLightLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = #colorLiteral(red: 0.2349999994, green: 0.2389999926, blue: 0.275000006, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func cellDataSet(obj: Review?) {
        labelContent.text = obj?.content
        textViewURL.text = obj?.url
        labelAuthor.text = "- " + (obj?.author ?? "")
    }
}
