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
}
