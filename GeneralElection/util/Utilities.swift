//
//  Utilities.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/14.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

/// appDelegate 선택하는 프로퍼티
var appDelegate: AppDelegate? {
    return UIApplication.shared.keyWindow?.appDelegate
}

/// 탭바 선택하는 프로퍼티
var mainTabBar: MainTabBarController? {
    return appDelegate?.window?.rootViewController?.presentedViewController as? MainTabBarController
}

