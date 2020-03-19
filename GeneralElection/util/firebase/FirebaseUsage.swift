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

class FirebaseUsage: NSObject {
    
    static func getPromotions() -> Observable<Promotion> {
        return Observable.create { (subscriber) -> Disposable in
            let ref:DatabaseReference = FirebaseManager.share.firebaseDB(path: .promotion)
            ref.keepSynced(true)
            ref.queryOrdered(byChild: "isValid").observeSingleEvent(of: .value, with: { snapShot in
                if !snapShot.hasChildren() {
                    return
                }
                
                let decoder = JSONDecoder()
                for child in snapShot.children.allObjects {
                    if !(child is DataSnapshot) {
                        continue
                    }
                    
                    let key = (child as! DataSnapshot).key
                    var value = (child as! DataSnapshot).value as! [String : Any]
                    let jsonData = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    guard let json = jsonData else {
                        continue
                    }
                    
                    let isSkipPromotion = self.checkForPromotionSkip(key: key)
                    if isSkipPromotion {
                        continue
                    }
                    
//                    JSONDecoder.decode(json, to: Promotion.self)
                    if let promotion = try? decoder.decode(Promotion.self, from: json)  {
                        guard let os = promotion.os, let minVersionName = promotion.minVersionName else {
                            continue
                        }
                        
                        if os != "iOS" || AppUtil.compareToCurrentVersion(version: "\(minVersionName)") == .newer {
                            continue
                        }
                        
                        if let isValid = promotion.isValid, !isValid {
                            continue
                        }
                        
                        guard let endTime = promotion.endTime else {
                            continue
                        }
                        
                        let df = DateFormatter.init()
                        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        df.timeZone = TimeZone.init(identifier: "KST")
                        df.locale = Locale.init(identifier: "ko_kr")
                        if let endDate = df.date(from: endTime), Date().compare(endDate) == .orderedDescending {
                            promotion.isValid = false
                            
                            value.updateValue(false, forKey: "isValid")
                            ref.child(key).updateChildValues(value)
                        } else {
                            promotion.key = key
                            subscriber.onNext(promotion)
                        }
                    }
                }
                subscriber.onCompleted()
                
            }) { (error) in
                print(error)
                subscriber.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    private static func checkForPromotionSkip(key:String) -> Bool {
        guard let config = RealmHelper.getUserConfig() else {
            return false
        }
        
        let skipList = config.promotionSkipList
        for skip in skipList {
            if skip.key == key {
                let skipDate = skip.skipDate
                if  skipDate.compare(Date())  == .orderedDescending {
                    return true
                }
            }
        }
        
        return false
    }
    
    static func savePromotionSkipInformation(promotion:Promotion) {
        if let userConfig = RealmHelper.getUserConfig() {
            let skipForDay = promotion.notLookForDay!
            let skipDate = Calendar.current.date(byAdding: .day, value: skipForDay, to: Date())
            
            let skipList = userConfig.promotionSkipList
            
            if let key = promotion.key, let date = skipDate {
                let promotionSkip = PromotionSkip()
                promotionSkip.key = key
                promotionSkip.skipDate = date
                skipList.append(promotionSkip)
                
                RealmHelper.insertUserConfig(config: userConfig)
            }
        }
    }
    
    static func checkPromotionPopup(result:@escaping ((Bool, Promotion?) -> ())) {
        _ = getPromotions()
            .subscribeOn(SerialDispatchQueueScheduler.init(qos: .background))
            .observeOn(MainScheduler.asyncInstance)
            .filter({ (promotion) -> Bool in
                if let type = promotion.type {
                    return type == "popup"
                }
                return false
            })
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { (promotion) in
                result(true, promotion)
                
            }, onError: { (error) in
                print(error)
                result(false, nil)
            })
    }

}
