//
//  PLImageView.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//


import UIKit
import SDWebImage

class PLImageView: UIImageView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// Set image from string URL and cache image
    /// - Parameter path: string url
    func setImage(forURL path: String?){
        if let strPath = path, let url = URL(string: strPath) {
            self.sd_setImage(with: url,placeholderImage: UIImage(named: "ic_placeholder"))
        }
    }
}
