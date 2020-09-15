//
//  CandidateSearchViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/12.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class CandidateSearchViewController: BaseViewControllerWithViewModel<CandidateSearchViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()
    }
}
