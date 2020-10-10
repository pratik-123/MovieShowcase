//
//  PLButton.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import UIKit

class PLButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.setup()
    }
    
    func setup() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        setTitleColor(#colorLiteral(red: 0.1330000013, green: 0.1529999971, blue: 0.1800000072, alpha: 1), for: .normal)
        self.setCornerRadius()
    }
}
