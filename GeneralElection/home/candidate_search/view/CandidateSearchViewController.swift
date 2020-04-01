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
    
    @IBOutlet weak var searchFieldBorderView: UIView!
    @IBOutlet weak var candidateSearchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        candidateSearchField.delegate = self
        setupUI()
        bindRx()
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()
        searchFieldBorderView.layer.borderWidth = 2
        searchFieldBorderView.layer.borderColor = UIColor(red: 127.toRgb,
                                                          green: 111.toRgb,
                                                          blue: 237.toRgb,
                                                          alpha: 1.0).cgColor
    }
    
    func bindRx() {
        searchButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
//                self.candidateSearchField.text
                // 검색 결과가 2이상이면
                self.nextViewController()
            }).disposed(by: rx.disposeBag)
    }
    
    func nextViewController() {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: CandidateSearchResultViewController.className) as? CandidateSearchResultViewController {

            vc.source = .candidateSearch
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CandidateSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        self.nextViewController()
        
        return true
    }
}
