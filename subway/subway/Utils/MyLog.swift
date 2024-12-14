//
//  MyLog.swift
//  subway
//
//  Created by 이윤주 on 12/12/24.
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
