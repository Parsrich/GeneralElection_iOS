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
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
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
        partyColorView.backgroundColor = PartyColor.getPartyColor(party: candidateInfo.party ?? "")
        partyNameLabel.text = candidateInfo.party
        candidateNameLabel.text = candidateInfo.name
        birthLabel.text = "(\(candidateInfo.age ?? "")/\(candidateInfo.gender ?? ""))"
        addressLabel.text = candidateInfo.address
        
    }
}
