//
//  MainTabBarController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setSelectedIndex(index: 1)
    }
    
    func setSelectedIndex(index: Int) {
        self.selectedIndex = index
    }
    
    func setData() {
        if CandidateMemory.candidateDict == nil {
            FirebaseHelper.fetchDatas(path: .candidateName)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe(onNext: { candidateDict in
                    CandidateMemory.candidateDict = candidateDict
                }).disposed(by: rx.disposeBag)
        }
    }
}
