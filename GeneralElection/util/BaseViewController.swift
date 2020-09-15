//
//  BaseViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setTransparentNavigationController() {
    
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    func setShadowViewUnderNavigationController() {
        let shadowView = ShadowView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 10))
        shadowView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        view.addSubViewWithFullAutoLayout(subview: shadowView, top: view.topSafeAreaInset + 44, bottom: nil)
    }
}
