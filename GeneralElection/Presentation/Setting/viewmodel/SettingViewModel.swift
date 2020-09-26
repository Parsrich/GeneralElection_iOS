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
    
    required init() {
        settingList = [String]()
        
        super.init()
        setup()
    }
    
    func setup() {
        settingList.append(contentsOf: ["공지사항",
            //"후원하기",
                                        "문의하기",
                                        "오픈소스 라이선스",
                                        "앱 버전: \(Config.appVersion)"])
    }
}
