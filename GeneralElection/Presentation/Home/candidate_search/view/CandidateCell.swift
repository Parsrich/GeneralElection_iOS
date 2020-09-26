//
//  CandidateCell.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/25.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import Kingfisher

class CandidateCell: BaseTableViewCellWithViewModel<CandidateCellViewModel> {
    
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
    
    @IBOutlet weak var resignView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let imgUrl = viewModel!.candidate?.imageUrl {
            let url = URL(string: imgUrl)
            thumbnailImageView
                .kf
                .setImage(with: url,
                          placeholder: UIImage(named: "ic_profile"))
        }
        numberColorView.backgroundColor = PartySource.getPartyColor(party: viewModel!.candidate?.party ?? "")
        
        numberLabel.text = viewModel!.candidate?.recommend == nil ? "기호\(viewModel!.candidate?.number ?? "")" : "번호\(viewModel!.candidate?.recommend ?? "")"
        partyColorView.backgroundColor = PartySource.getPartyColor(party: viewModel!.candidate?.party ?? "")
        partyNameLabel.text = viewModel!.candidate?.party
        candidateNameLabel.text = viewModel!.candidate?.name
        birthLabel.text = "\(viewModel!.candidate?.age ?? "")/\(viewModel!.candidate?.gender ?? "")"
        addressLabel.text = viewModel!.candidate?.address
        
        resignView.isHidden = viewModel!.candidate?.status != "resign"
        self.isUserInteractionEnabled = viewModel!.candidate?.status != "resign"
    }
}
