//
//  App+Extension.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import UIKit
//MARK:- UIView extended methods
extension UIView {
    /// Corner radius set
    /// - Parameter cornerRadius: Radius value, defaultValue  =16
    func setCornerRadius(cornerRadius: CGFloat = 16) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
