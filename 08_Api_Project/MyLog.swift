//
//  MyLog.swift
//  08_Api_Project
//
//  Created by 이윤주 on 10/26/24.
//

import Foundation
import Alamofire

final class MyLog : EventMonitor{
    let queue = DispatchQueue(label:"ApiLog")
    func requestDidResume(_ request: Request) {
        print("MyLogger - requestDidResume()")
        debugPrint(request)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) where Value : Sendable {
        print("MyLogger - didParseResponse()")
        debugPrint(response )
    }
}
