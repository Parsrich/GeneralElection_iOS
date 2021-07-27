//
//  MainTabBarController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import GoogleMobileAds

class MainTabBarController: UITabBarController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setSelectedIndex(index: 1)
        self.tabBar.barStyle = .default
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } 
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
                }, onError: {[weak self] error in
                    self?.showNetworkErrorView {
                        self?.setData()
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    func showConfirmationAlert(alertTitle title: String, alertMessage message: String, buttonText: String = "OK", completionHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default, handler: completionHandler)
        alertController.addAction(action)
        return alertController
    }
    
    func showNetworkErrorView(retryHandler: @escaping () -> Void) {
        
        let alert = showConfirmationAlert(alertTitle: "네트워크 에러", alertMessage: "네트워크를 확인해 주세요.", buttonText: "재시도") { _ in
            retryHandler()
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
