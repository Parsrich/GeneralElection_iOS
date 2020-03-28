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
    
    @IBOutlet weak var districtLabel: UILabel!
    
    var candidate: Candidate?
    var districtString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let candidate = candidate, let districtString = districtString {
            viewModel!.candidate = candidate
            viewModel!.districtString = districtString
        }
        
        setupUI()
        setup()
    }
    
    func setup() {
        
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()

        districtLabel.text = districtString
    }
    
}
