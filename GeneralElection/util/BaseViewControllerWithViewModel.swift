//
//  BaseViewControllerWithViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class BaseViewControllerWithViewModel<T: BaseViewModel>: BaseViewController {
    
    var viewModel: T?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = T()
    }
}
