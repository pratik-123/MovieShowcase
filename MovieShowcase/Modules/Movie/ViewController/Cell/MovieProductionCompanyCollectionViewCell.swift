//
//  MovieProductionCompanyCollectionViewCell.swift
//  MovieShowcase
//
//  Created by Pratik on 11/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import UIKit

class MovieProductionCompanyCollectionViewCell: UICollectionViewCell {
    static let identifer = String(describing: MovieProductionCompanyCollectionViewCell.self)
    @IBOutlet weak var imageViewLogo: PLImageView!
    @IBOutlet weak var labelCompanyname: PLSubTitleLightLabel!
    
    func cellDataSet(obj : ProductionCompanies?) {
        labelCompanyname.text = obj?.name
        if let imageName = obj?.logo_path {
            let endPoint = APIManager.EndPoint.LogoImage(imageName: imageName)
            let request = APIManager.EndPoint.generateRequest(for: endPoint)
            imageViewLogo.setImage(forURL: request.url)
        }
    }
}
