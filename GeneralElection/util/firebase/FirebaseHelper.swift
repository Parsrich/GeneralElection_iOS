//
//  FirebaseUsage.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/19.
//  Copyright © 2020 Parsrich. All rights reserved.
//
import UIKit
import RxSwift
import FirebaseDatabase

class FirebaseHelper: NSObject {
    
    static func fetchDatas(path: DatabasePath, key: String? = nil) -> Observable<NSDictionary> {
        return Observable.create { emitter -> Disposable in
            
            var dbReference = FirebaseManager.share.firebaseDB(path: path)
            
            if let location = key {
                dbReference = dbReference.child(location)
            }
            
            dbReference.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? NSDictionary {
                    emitter.onNext(dict)
                    emitter.onCompleted()
                }
                if let dicts = snapshot.value as? [NSDictionary] {
                    dicts.forEach { emitter.onNext($0) }
                    emitter.onCompleted()
                }
            }) { error in
                print(error.localizedDescription)
            }
            return Disposables.create()
        }
    }
}
