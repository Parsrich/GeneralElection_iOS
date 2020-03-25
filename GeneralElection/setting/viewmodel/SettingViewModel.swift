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
    
    required init() {
        settingList = [String]()
        
        super.init()
        
        settingList.append(contentsOf: ["파슬리치 소개",
                                        "후원하기",
                                        "오류 문의",
                                        "오픈소스 라이선스"])
//        settingList.append(contentsOf: ["알림 설정",
//                                        "파슬리치 소개",
//                                        "후원하기",
//                                        "오류 문의"])
    }
}
