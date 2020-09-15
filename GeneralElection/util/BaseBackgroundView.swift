//
//  BaseBackgroundView.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/14.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

class BaseBackgroundView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        let backgroundImageView = UIImageView(frame: self.frame)
        backgroundImageView.image = UIImage(named: "img_background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = false
        addSubViewWithFullAutoLayout(subview: backgroundImageView, bottom: nil)
        sendSubviewToBack(backgroundImageView)
    }
}
