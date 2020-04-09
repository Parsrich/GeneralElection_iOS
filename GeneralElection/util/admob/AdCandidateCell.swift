//
//  AdCandidateCell.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/05.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import GoogleMobileAds
import RxSwift

class AdCandidateCell: UITableViewCell {
    
    @IBOutlet weak var adViewHeightConstraint: NSLayoutConstraint!
    var setupFlag = true
    private var heightSubject = BehaviorSubject<CGFloat>(value: 0)
    var heightObservable: Observable<CGFloat> {
        return heightSubject.asObservable()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
