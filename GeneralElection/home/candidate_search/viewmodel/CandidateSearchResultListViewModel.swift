//
//  CandidateSearchListResultViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/20.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift

class CandidateSearchListResultViewModel: BaseViewModel {
    
    var electionType: ElectionType
    var electionName: LocationElectionName
    
    var congressCandidateList: [Candidate]
    
    required init() {
        electionType = .nationalAssembly
        electionName = LocationElectionName(dictionary: nil)
        
        congressCandidateList = [Candidate]()
        
        super.init()
    }
    
    func fetchElectionKeys(completion: @escaping () -> Void) {
        
        var path: DatabasePath = .root
        switch electionType {
        case .nationalAssembly:
            path = .congress
            if Congress.congressDict == nil {
                FirebaseHelper.fetchDatas(path: path)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                    .observeOn(MainScheduler.asyncInstance)
                    .subscribe(onNext: { congressDict in
                        Congress.congressDict = congressDict
                        
                    }, onCompleted: { [weak self] in
                        self?.bindData()
                        completion()
                    }).disposed(by: rx.disposeBag)
                return
            }
        case .guMayor:
            path = .guMayor
            if Congress.guMayorDict == nil {
                FirebaseHelper.fetchDatas(path: path)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                    .observeOn(MainScheduler.asyncInstance)
                    .subscribe(onNext: { guMayorDict in
                        Congress.guMayorDict = guMayorDict
                        
                    }, onCompleted: { [weak self] in
                        self?.bindData()
                        completion()
                    }).disposed(by: rx.disposeBag)
                return
            }
        case .siCouncil:
            path = .siCouncil
            if Congress.siCouncilDict == nil {
                FirebaseHelper.fetchDatas(path: path)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                    .observeOn(MainScheduler.asyncInstance)
                    .subscribe(onNext: { siCouncilDict in
                        Congress.siCouncilDict = siCouncilDict
                        
                    }, onCompleted: { [weak self] in
                        self?.bindData()
                        completion()
                    }).disposed(by: rx.disposeBag)
                return
            }
        case .guCouncil:
            path = .guCouncil
            if Congress.guCouncilDict == nil {
                FirebaseHelper.fetchDatas(path: path)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                    .observeOn(MainScheduler.asyncInstance)
                    .subscribe(onNext: { guCouncilDict in
                        Congress.guCouncilDict = guCouncilDict
                        
                    }, onCompleted: { [weak self] in
                        self?.bindData()
                        completion()
                    }).disposed(by: rx.disposeBag)
                return
            }
        default:
            break
        }
        
//        if Congress.congressDict == nil && electionType == .nationalAssembly {
//            FirebaseHelper.fetchDatas(path: path)
//                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//                .observeOn(MainScheduler.asyncInstance)
//                .subscribe(onNext: { congress in
//                    Congress.congressDict = congress
//
//                    }, onCompleted: { [weak self] in
//                        self?.bindData()
//                        completion()
//                }).disposed(by: rx.disposeBag)
//            return
//        }
        
        bindData()
        completion()
    }
    
    func bindData() {
        setCongressCandidateList()
    }
    
    func setCongressCandidateList() {
        var congresses: NSDictionary? = nil
        switch electionType {
        case .nationalAssembly:
            congresses = Congress.congressDict
        case .guMayor:
            congresses = Congress.guMayorDict
        case .siCouncil:
            congresses = Congress.siCouncilDict
        case .guCouncil:
            congresses = Congress.guCouncilDict
        default:
            break
        }
        /// # TODO: - electionName이 동대문아선거구로 돼서 이상함. candidate페이지에서 버튼 눌러도 "동대문구을"에서 안바뀜
        guard let electionDict = congresses,
            let candidates = electionDict.value(forKey: self.electionName.getElectionName(electionType: electionType)) as? [NSDictionary],
            let data = try? JSONSerialization.data(withJSONObject: candidates, options: .prettyPrinted) else { return }
//        let data = NSKeyedArchiver.archivedData(withRootObject: candidates)
//        let data = Data(candidates)
        congressCandidateList.removeAll()
        
        if let candidateList = try? JSONDecoder().decode([Candidate].self, from: data) {
            congressCandidateList.append(contentsOf: candidateList)
        }
        
        print("count: \(congressCandidateList.count)")
    }
    
    func switchElectionType(electionType: ElectionType) {
        self.electionType = electionType
    }
}
