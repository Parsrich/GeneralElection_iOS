//
//  IntroduceViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/05.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

class IntroduceViewController: BaseViewController {
    
    @IBOutlet weak var contentsLabel: UILabel!
    var savedMessage: String? {
        get {
            return UserDefaults.standard.string(forKey: "introduceMessage")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "introduceMessage")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        FirebaseManager.share.fetch {  [weak self] isComplete in
            guard let `self` = self else { return }
            if !isComplete {
                DispatchQueue.main.async {
                    self.contentsLabel.text = self.savedMessage
                }
                return
            }
            
            let message = FirebaseManager.share.stringValue(key: .introduceMessage)

            
            
            
            DispatchQueue.main.async {
                self.savedMessage = message.replacingOccurrences(of: "\\n", with: "\n") 
                self.contentsLabel.text = self.savedMessage
            }
            
        }
        
    }
}
