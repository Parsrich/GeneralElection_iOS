//
//  MainTabBarController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSelectedIndex(index: 1)
    }
    
    func setSelectedIndex(index: Int) {
        self.selectedIndex = index
    }
}
