//
//  MyAlamofireManager.swift
//  08_Api_Project
//
//  Created by 이윤주 on 10/26/24.
//

import Foundation
import Alamofire

final class MyAlamofireManager{
    // 싱글톤 적용
    static let shared = MyAlamofireManager()
    
    // 1. 인터셉터
    // 배열로 여러개의 인터셉터 추가 가능
    let intercepters = Interceptor(interceptors: [BaseInterceptor()])
    
    // 2. 로거 설정
    let monitors = [MyLog(),] as [EventMonitor]
    
    // 3. 세션 설정
    var session :Session
    private init(){
        session = Session(interceptor:intercepters, eventMonitors: monitors)
        
    }
}
