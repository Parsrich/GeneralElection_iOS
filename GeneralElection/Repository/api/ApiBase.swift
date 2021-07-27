//
//  ApiBase.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/03.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol ApiProtocol {
    associatedtype RESULT
    func request() -> Observable<RESULT>
    
    var url: String { get }
    
    var timeoutInterval: TimeInterval { get set }
    var params: [String: String]? { get set }
    var requestHeader: [String: String]? { get set }
    var method: HTTPMethod { get }
}


class ApiBase<R>: ApiProtocol {
    
    class var host: String {
        return "http://apis.data.go.kr"
    }
    
    var host: String {
        return Self.host
    }
    
    var url: String {
        return "\(Self.host)/\(path)"
    }
    
    var path: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var timeoutInterval: TimeInterval = 10.0
    
    var params: [String: String]?
    var requestHeader: [String: String]?
    
    
    func request() -> Observable<R> {
        return BaseNetwork.requestObject(url: url,
                                         method: method,
                                         parameters: params,
                                         body: nil,
                                         header: requestHeader,
                                         timeoutInterval: timeoutInterval)
    }
}
