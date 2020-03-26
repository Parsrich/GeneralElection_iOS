//
//  NoticeViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift
import NSObject_Rx
import ImageSlideshow

class NoticeViewModel: BaseViewModel {
    
    var votingImageSources: [ImageSource]
    
    required init() {
        votingImageSources = [ImageSource]()
        for i in 0...9 {
            votingImageSources.append(ImageSource(image: UIImage(named: "img_vote_\(i)")!))
        }
        
        super.init()
        
        setup()
    }
    
    func setup() {
        
    }
}
