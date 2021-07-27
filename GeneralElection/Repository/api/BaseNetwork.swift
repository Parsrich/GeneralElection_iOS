//
//  BaseNetwork.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/03.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import SwiftyJSON

extension Decodable {
    init(jsonData: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: jsonData)
    }
}

extension JSONDecoder {
    func decode<T>(data: Data, dataType: T.Type) throws -> T {
        var object: T
        if dataType is Void.Type {
            object = (() as? T)!
        } else if dataType is String.Type {
            object = (String(data: data, encoding: .utf8) as? T)!
        } else if let decodableType = dataType as? Decodable.Type {
            object = try (decodableType.init(jsonData: data) as? T)!
        } else {
            let jsonObject = JSON(data)
            let error = jsonObject["error"]
            if error.isEmpty == false {
                do {
                    let data = try error.rawData()
                    let responseError = try JSONDecoder().decode(ApiError.self, from: data)
                    throw responseError
                } catch {
                    throw ApiError(message: "Response Error")
                }
           } else {
               if dataType is JSON.Type {
                   object = (jsonObject as? T)!
               } else if let dic = jsonObject.dictionaryObject as? T {
                   object = dic
               } else if let array = jsonObject.arrayObject as? T {
                   object = array
               } else {
                   throw NSError(domain: "Response Error", code: -1)
               }
           }
        }
        return object
    }
}

extension HTTPURLResponse {
    func isSuccess() -> Bool {
        let code = self.statusCode
        if code >= 200, code < 210 {
            return true
        }
        
        return false
    }
}

protocol BaseApi: class {
    var url: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get set }
}


protocol ReqeustServiceProtocol {
    
    func requestObject<T>(url: String,
                          method: HTTPMethod,
                          parameters: [String: Any]?,
                          body: Data?,
                          header: [String: String]?) -> Observable<T>
}

class BaseNetwork {
    
    
    static func covertRequestBody<T>(_ object: T) -> Data?  where T: Encodable {
            do {
                let data = try JSONEncoder().encode(object)
                return data
            } catch {
            }
            return nil
    }
        
    class func request(url: String,
                       method: HTTPMethod,
                       parameters: [String: Any]?,
                       body: Data? = nil,
                       timeoutInterval: TimeInterval = 30.0,
                       header: [String: String]? = nil)  -> Observable<(HTTPURLResponse, Data)> {
        
        let encoding = URLEncoding.default
        var originalRequest: URLRequest?
        do {
            originalRequest = try URLRequest(url: url,
                                             method: method,
                                             headers: header)
            if let param = parameters {
                let encodedURLRequest = try encoding.encode(originalRequest!, with: param)
                originalRequest = encodedURLRequest
            }
            originalRequest?.httpBody = body
            originalRequest?.timeoutInterval = timeoutInterval
            
            let ret = RxAlamofire.requestData(originalRequest!)
            #if DEBUG
            return ret.debug()
            #else
            return ret
            #endif
        } catch {
            let observable: Observable<(HTTPURLResponse, Data)> =  Observable.create { (subscriber) -> Disposable in
                subscriber.onError(error)
                return Disposables.create()
            }
            return observable
        }
    }
    
    class func requestObject<T>(url: String,
                                method: HTTPMethod,
                                parameters: [String: Any]? = nil,
                                body: Data? = nil,
                                header: [String: String]? = nil,
                                timeoutInterval: TimeInterval = 10.0) -> Observable<T> {
        let observable: Observable<T> =  Observable.create { (subscriber) -> Disposable in
            
            return request(url: url, method: method, parameters: parameters, body: body, header: header)
                .subscribe( onNext: { (response, data) in
                    do {
                        if response.isSuccess() {
                            
                            let object: T = try JSONDecoder().decode(data: data, dataType: T.self)
                            
                            subscriber.onNext(object)
                            subscriber.onCompleted()
                            
                        } else {
                            if let msg = String(data: data, encoding: .utf8) {
                                print(msg)
                            }
                            
                            let errMsg = try JSONDecoder().decode([String: String].self, from: data)["message"]
                            subscriber.onError(ApiError(url: response.url?.absoluteString,
                                                        errorCode: response.statusCode,
                                                        message: errMsg))
                        }
                        
                    } catch {
                        if let errorMessage = String(data: data, encoding: .utf8) {
                            print(errorMessage)
                        }
                        
                        let errMsg = try? JSONDecoder().decode([String: String].self, from: data)["message"]
                        subscriber.onError(ApiError(url: response.url?.absoluteString,
                                                    errorCode: response.statusCode,
                                                    message: errMsg))
                    }
                }, onError: { (error) in
                    subscriber.onError(ApiError(url: url, message: "네트워크를 확인해주세요."))
                    print("newtwork : error \(error)")
                })
        }
        
        return observable
    }
    
}

class ApiBaseWithData<T: Encodable, R>: ApiBase<R> {
    
    var requestObject: T?
    
    init(requestObject: T? = nil) {
        self.requestObject = requestObject
    }
    
    override func request() -> Observable<R> {
        var data: Data?
        if let object = requestObject {
            data = BaseNetwork.covertRequestBody(object)
        }
        return BaseNetwork.requestObject(url: url,
                                         method: method,
                                         body: data,
                                         header: requestHeader,
                                         timeoutInterval: timeoutInterval)
    }
}

class ApiError: Error, Decodable {
    var url: String?
    var errorCode: Int
    var message: String?
    
    init(url: String? = nil, errorCode: Int = -1, message: String? = nil) {
        self.url = url
        self.errorCode = errorCode
        self.message = message
    }
}
