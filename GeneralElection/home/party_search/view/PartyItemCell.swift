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
    
    func setup(info: [String: String]) {
        guard let partyName = info.keys.first else { return }
        nameLabel.text = partyName
        if let imgUrl = info[partyName] {
            let url = URL(string: imgUrl)
            partyLogoImageView
                .kf
                .setImage(with: url,
                          placeholder: UIImage(named: "ic_user_empty"))
        }
    }
}
