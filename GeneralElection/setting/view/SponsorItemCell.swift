//
//  SponsorItemCell.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/29.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class SponsorItemCell: UITableViewCell {
    
    @IBOutlet weak var desertImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    var price = 1000
    var completionSubject = PublishSubject<Void>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    func setup() {
        priceButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                print("\(self.price)")
                
                /// 완료시 수행
                self.completionSubject.onNext(())
            }).disposed(by: rx.disposeBag)
    }
    
    func setData(sponsorItem: SponsorItem) {
        price = sponsorItem.price
        desertImageView.image = sponsorItem.image
        titleLabel.text = sponsorItem.title
        priceButton.setTitle(sponsorItem.priceString, for: .normal)
    }
    
}

struct SponsorItem {
    var image: UIImage
    var title: String
    var priceString: String
    var price: Int
}
