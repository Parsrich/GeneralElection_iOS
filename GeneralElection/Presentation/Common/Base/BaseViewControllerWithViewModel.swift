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
import Firebase

class BaseViewControllerWithViewModel<T: BaseViewModel>: BaseViewController {
    
    var viewModel: T?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        viewModel = T()
//    }
}

protocol Inputable {}
protocol Outputable {}
