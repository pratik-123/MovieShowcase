//
//  MovieListTableViewCell.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    static let identifer = String(describing: MovieListTableViewCell.self)
    @IBOutlet weak var viewBottomParent: UIView!
    @IBOutlet weak var labelMovieName: PLTitleLabel!
    @IBOutlet weak var labelReleaseDate: PLSubTitleLabel!
    @IBOutlet weak var imageViewPoster: PLImageView!
    @IBOutlet weak var labelOverview: PLSubTitleLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        viewBottomParent.setCornerRadius()
        imageViewPoster.setCornerRadius()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func cellDataSet(data : MovieListModel?) {
        labelMovieName.text = data?.title
        labelReleaseDate.text = data?.displayDate
        labelOverview.text = data?.overview
        if let imageName = data?.poster_path {
            let endPoint = APIManager.EndPoint.PosterImage(imageName: imageName)
            let request = APIManager.EndPoint.generateRequest(for: endPoint)
            imageViewPoster.setImage(forURL: request.url)
        }
    }
}
