//
//  MovieSimilerCollectionViewCell.swift
//  MovieShowcase
//
//  Created by Pratik on 12/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import UIKit

class MovieSimilerCollectionViewCell: UICollectionViewCell {
    static let identifer = String(describing: MovieSimilerCollectionViewCell.self)
    @IBOutlet weak var imageViewPoster: PLImageView!
    @IBOutlet weak var labelMovieName: PLSubTitleLightLabel!

    func cellDataSet(obj : MovieListModel?) {
        labelMovieName.text = obj?.title
        if let imageName = obj?.poster_path {
            let endPoint = APIManager.EndPoint.PosterImage(imageName: imageName)
            let request = APIManager.EndPoint.generateRequest(for: endPoint)
            imageViewPoster.setImage(forURL: request.url)
        }
    }
}
