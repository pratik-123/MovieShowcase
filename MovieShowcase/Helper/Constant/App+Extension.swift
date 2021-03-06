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
    /// - Parameter cornerRadius: Radius value, defaultValue  =8
    func setCornerRadius(cornerRadius: CGFloat = 8) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
extension String {
    
    /// Date formate change
    func dateFormateChange(currentDateFormate: DateFormater, returnDateFormate: DateFormater = .DisplayFormate) -> String? {
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = currentDateFormate.rawValue
        if let convertDate = dateFormate.date(from: self) {
            dateFormate.dateFormat = returnDateFormate.rawValue
            let returnDate = dateFormate.string(from: convertDate)
            return returnDate
        }
        return nil
    }
}
