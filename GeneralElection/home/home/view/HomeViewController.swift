//
//  HomeViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class HomeViewController: BaseViewControllerWithViewModel<HomeViewModel> {

    @IBOutlet weak var noticeButton: UIButton!
    @IBOutlet weak var partySearchButton: UIButton!
    @IBOutlet weak var districtSearchButton: UIButton!
    @IBOutlet weak var candidateSearchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindRx()
    }
    
    func setupUI() {
        setTransparentNavigationController()
    }
    
    func bindRx() {
        noticeButton.rx.tap
            .map { 0 }
            .asDriver(onErrorJustReturn: 0)
            .drive(onNext: mainTabBar?.setSelectedIndex(index:))
            .disposed(by: rx.disposeBag)
        
        partySearchButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                if let vc = self?.selectViewController(.homeDetail, viewControllerName: PartySearchViewController.className) as? PartySearchViewController {
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }).disposed(by: rx.disposeBag)
        
        districtSearchButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
            if let vc = self?.selectViewController(.homeDetail, viewControllerName: DistrictSearchViewController.className) as? DistrictSearchViewController {
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            }).disposed(by: rx.disposeBag)
        
        candidateSearchButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
            if let vc = self?.selectViewController(.homeDetail, viewControllerName: CandidateSearchViewController.className) as? CandidateSearchViewController {
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            }).disposed(by: rx.disposeBag)
    }
    

}

