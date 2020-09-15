//
//  SettingViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift
import NSObject_Rx

class SettingViewModel: BaseViewModel {
    var settingList: [String]
    var appVersion = "0.0.0"
    var firebaseFetchSubject: PublishSubject<String>
    
    required init() {
        settingList = [String]()
        firebaseFetchSubject = PublishSubject<String>()
        
        super.init()
        setup()
    }
    
    func setup() {
        FirebaseManager.share.fetch { [weak self] isComplete in
            guard let `self` = self else { return }
            if !isComplete { return }
            self.firebaseFetchSubject.onNext(FirebaseManager.share.stringValue(key: .appVersion))
        }
        
        settingList.append(contentsOf: ["후원하기",
                                        "오류 문의",
                                        "오픈소스 라이선스",
                                        "앱 버전: \(appVersion)"])
    }
}
