//
//  BaseViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift
import Firebase

class BaseViewModel: NSObject {
    
    var disposeBag = DisposeBag()
    
    override init() {
        super.init()
    }
}
