//
//  CandidateDetailWebViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/31.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import WebKit

class CandidateDetailWebViewController: BaseViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    
    var url: URL?
    var navigationTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = self.url {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
        
        navigationTitleLabel.text = navigationTitle
        setTransparentNavigationController(false)
    }
}
