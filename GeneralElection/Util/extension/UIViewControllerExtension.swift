//
//  UIViewControllerExtension.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

extension UIViewController {
    var className: String {
        return String.init(describing: self).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String.init(describing: self).components(separatedBy: ".").last!
    }
    
    var topSafeAreaHeight: CGFloat {
        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top ?? 0
        return topPadding
    }
    
    var bottomSafeAreaHeight: CGFloat {
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        return bottomPadding
    }
}
