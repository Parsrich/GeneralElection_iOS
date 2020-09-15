//
//  CandidateSearchResultViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/20.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class CandidateSearchResultViewController: BaseViewControllerWithViewModel<CandidateSearchResultViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()
    }
    
}
