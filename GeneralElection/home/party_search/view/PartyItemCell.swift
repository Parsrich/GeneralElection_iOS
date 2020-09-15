//
//  PartyItemCell.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/01.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class PartyItemCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partyLogoImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 2.0
    }
    
    func setData(info: Party) {
        
        nameLabel.text = info.name
        if let url = info.logoImg {
            partyLogoImageView
                .kf
                .setImage(with: url,
                          placeholder: UIImage(named: "ic_user_empty"))
            if info.name?.contains("가자!평화인권당") == true {
                partyLogoImageView.backgroundColor = UIColor.init(hex: "#65A032")
            } else {
                partyLogoImageView.backgroundColor = UIColor.white
            }
        }
    }
}
