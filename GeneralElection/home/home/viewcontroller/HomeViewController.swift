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
    @IBOutlet weak var districtSearchButton: UIButton!
    @IBOutlet weak var candidateSearchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bindRx()
    }
    
    func bindRx() {
        noticeButton.rx.tap
            .map { 0 }
            .asDriver(onErrorJustReturn: 0)
            .drive(onNext: mainTabBar?.setSelectedIndex(index:))
            .disposed(by: rx.disposeBag)
        
//        districtSearchButton.rx.tap
//            .asDriver()
//            .drive(onNext: { [weak self] _ in
//                self?.db.collection("district").getDocuments(completion: { query, error in
//                    if let error = error {
//                        print("Error: \(error)")
//                    } else {
//                        for document in query!.documents {
//                            print("\(document.documentID) => \(document.data())")
//                        }
//                    }
//                })
//            })
//            .disposed(by: rx.disposeBag)
//        
//        candidateSearchButton.rx.tap
//            .asDriver()
//            .drive(onNext: { [weak self] _ in
//                self?.db.collection("candidate").getDocuments(completion: { query, error in
//                    if let error = error {
//                        print("Error: \(error)")
//                    } else {
//                        for document in query!.documents {
//                            print("\(document.documentID) => \(document.data())")
//                        }
//                    }
//                })
//            })
//            .disposed(by: rx.disposeBag)
    }
    
    func setup() {
        setTransparentBackground()
        /// 파베 불러오기 예제
//        db.collection("users").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
    }

}

