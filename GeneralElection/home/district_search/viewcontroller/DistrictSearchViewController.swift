//
//  DistrictSearchViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/12.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class DistrictSearchViewController: BaseViewControllerWithViewModel<DistrictSearchViewModel> {
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.makeShadow(shadowRadius: 5.0)
//        viewModel?.getDocuments(in: .district, errorHandler: { error in
//            print("error: \(error)")
//        }, completionHandler: { querySnapshot in
//            print("count: \(querySnapshot!.documents.count)")
//            for document in querySnapshot!.documents {
//                print("\(document.documentID): \(document.data()))")
//            }
//        })
    }
}

/**

 viewModel?.getDocuments(in: .candidate, errorHandler: { error in
     print("error: \(error)")
 }, completionHandler: { querySnapshot in
     print("count: \(querySnapshot!.documents.count)")
     for document in querySnapshot!.documents {
         print("\(document.documentID): \(document.data()))")
     }
 })
 
 */
