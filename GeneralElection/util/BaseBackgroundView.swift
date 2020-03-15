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
        let imageView = UIImageView(frame: self.frame)
        imageView.image = UIImage(named: "img_background")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        addSubViewWithFullAutoLayout(subview: imageView, bottom: nil)
    }
}
