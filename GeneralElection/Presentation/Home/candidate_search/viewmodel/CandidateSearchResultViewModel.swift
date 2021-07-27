//
//  CandidateSearchResultViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/20.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift

typealias DetailInfo = (title: String?, content: String?)

class CandidateSearchResultViewModel: BaseViewModel {
    
    var candidate: Candidate?
    var districtString: String?
    var detailInfo: [DetailInfo]?
    
    override init() {
        super.init()
        
    }
    
    func setDetailInfo() {
        guard let candidate = self.candidate else { return }
        if detailInfo == nil {
            detailInfo = [DetailInfo]()
        }
        detailInfo!.removeAll()
        
        detailInfo!.append(DetailInfo(title: "직업", content: candidate.job))
        detailInfo!.append(DetailInfo(title: "학력", content: candidate.education))
        detailInfo!.append(DetailInfo(title: "경력", content: candidate.career))
        detailInfo!.append(DetailInfo(title: "재산\n신고액(천원)", content: candidate.property))
        detailInfo!.append(DetailInfo(title: "병역\n신고사항(본인)", content: candidate.military))
        detailInfo!.append(DetailInfo(title: "전과\n기록유무(건수)", content: candidate.criminal))
        detailInfo!.append(DetailInfo(title: "입후보횟수", content: candidate.regCount))
        detailInfo!.append(DetailInfo(title: "세금납부액", content: candidate.taxPayment))
        detailInfo!.append(DetailInfo(title: "최근 5년간\n체납액", content: candidate.taxArrears5))
        detailInfo!.append(DetailInfo(title: "현 체납액", content: candidate.taxArrears))
    }
}
