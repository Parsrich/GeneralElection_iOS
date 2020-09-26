//
//  NoticeViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift
import RxCocoa
import NSObject_Rx
import ImageSlideshow

class NoticeViewModel: BaseViewModel {
    
    struct Input: Inputable {
        let initialSetting: Driver<Void>
    }
    
    struct Output: Outputable {
        let imageBinding: Driver<[ImageSource]>
    }
    
    init(input: Input) {
        
        super.init()
    }
    
    func transform(input: Input) -> Output {
        let imagesObservable = input.initialSetting
            .flatMap {
                Observable
                    .from(makeImages())
                    .asDriver(onErrorJustReturn: [ImageSource]())
            }
        
        return Output(imageBinding: imagesObservable)
    }
    
    private func makeImages() -> [ImageSource] {
        let list = [ImageSource]()
        for i in 0...9 {
            list.append(ImageSource(image: UIImage(named: "img_vote_\(i)")!))
        }
        return list
    }
}
