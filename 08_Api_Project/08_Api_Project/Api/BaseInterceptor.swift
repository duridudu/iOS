//
//  BaseInterceptor.swift
//  08_Api_Project
//
//  Created by 이윤주 on 10/26/24.
//

import Foundation
import Alamofire

class BaseInterceptor:RequestInterceptor{
    // 어답터 : API 호출 시
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        print("BaseInterceptor : adapt() called")
        var request = urlRequest
        // content와 accept을 json으로 받겠다.
        request.addValue( "application/json; charset=UTF-8" , forHTTPHeaderField: "Content-Type")
        request.addValue( "application/json; charset=UTF-8" , forHTTPHeaderField: "Accept")
         
        // 공통 파라미터 추가
        var dictionary = [String:String]()
        dictionary.updateValue(API.CLIENT_ID, forKey: "client_id")
        do{
            request = try URLEncodedFormParameterEncoder().encode(dictionary, into: request)
        }catch{
            print(error)
        }
        
        completion(.success(request))
    }
    // 리트라이
    func retry(_ request: Request,   session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        print("BaseInterceptor : retry() called")
        // 다시 호출할거냐 말거냐 . . .
        completion(.doNotRetry)
    }
}
