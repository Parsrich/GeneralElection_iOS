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


enum StoryboardName: String {
    case main = "main"
    case notice = "Notice"
    case home = "home"
    case setting = "Setting"
    case homeDetail = "HomeDetail"
}

class BaseViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        makeAcitivityIndicator()
    }
    
    func setTransparentNavigationController() {
    
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "img_background"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    func setShadowViewUnderNavigationController() {
        let shadowView = ShadowView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 10))
        shadowView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        view.addSubViewWithFullAutoLayout(subview: shadowView, top: view.topSafeAreaInset + 44, bottom: nil)
    }
    
    func selectViewController(_ storyboardName: StoryboardName, viewControllerName vcName: String? = nil) -> UIViewController? {
        
        let storyboard = UIStoryboard(name: storyboardName.rawValue,
                                      bundle: nil)
        
        if let name = vcName {
            return storyboard.instantiateViewController(withIdentifier: name)
        }
        
        return storyboard.instantiateInitialViewController()
    }

    func presentActionSheet(title: String? = nil, message: String? = nil, actions: [UIAlertAction]) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions {
            actionSheet.addAction(action)
        }
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)

    }
    
    func makeAcitivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.frame)
        
        let color = UIColor(red: 127.toRgb, green: 111.toRgb, blue: 237.toRgb, alpha: 1.0)
        activityIndicator.color = color
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    }
    
    func showConfirmationAlert(alertTitle title: String, alertMessage message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
