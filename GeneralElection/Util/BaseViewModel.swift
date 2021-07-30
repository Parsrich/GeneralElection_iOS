//
//  BaseViewModel.swift
//  GeneralElection
//
//  Created by devming on 2021/07/31.
//  Copyright © 2021 Parsrich. All rights reserved.
//

import RxSwift
import Firebase

class BaseViewModel: NSObject {
    
    var disposeBag = DisposeBag()
    
    override init() {
        super.init()
    }
}
