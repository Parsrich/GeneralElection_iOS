//
//  NoticeViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class NoticeViewController: BaseViewControllerWithViewModel<NoticeViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        setTransparentNavigationController()
        setShadowViewUnderNavigationController()
    }
}

