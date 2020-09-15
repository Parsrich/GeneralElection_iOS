//
//  CandidateCell.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/25.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import Kingfisher

class CandidateCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            self.thumbnailImageView.layer.borderColor = UIColor.lightGray.cgColor
            self.thumbnailImageView.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var numberColorView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var partyColorView: UIView!
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var candidateNameLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    func setCandidate(candidateInfo: Candidate) {
        if let imgUrl = candidateInfo.imageUrl {
            let url = URL(string: imgUrl)
            thumbnailImageView
                .kf
                .setImage(with: url,
                          placeholder: UIImage(named: "ic_user_empty"))
        }
        numberColorView.backgroundColor = PartySource.getPartyColor(party: candidateInfo.party ?? "")
        numberLabel.text = "기호\(candidateInfo.number ?? "")"
        partyColorView.backgroundColor = PartySource.getPartyColor(party: candidateInfo.party ?? "")
        partyNameLabel.text = candidateInfo.party
        candidateNameLabel.text = candidateInfo.name
        birthLabel.text = "\(candidateInfo.age ?? "")/\(candidateInfo.gender ?? "")"
        addressLabel.text = candidateInfo.address
    }
}
