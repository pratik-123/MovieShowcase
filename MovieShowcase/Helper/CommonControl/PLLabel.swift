//
//  PLLabel.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import UIKit

///normal system font size 18
class PLTitleLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.setup()
    }
    
    func setup() {
        font = UIFont.systemFont(ofSize: 18)
        textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
///system font size 14
class PLSubTitleLabel: PLTitleLabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    override func setup() {
        super.setup()
        font = UIFont.systemFont(ofSize: 14)
    }
}
