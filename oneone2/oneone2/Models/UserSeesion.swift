//
//  UserSeesion.swift
//  oneone2
//
//  Created by 이윤주 on 11/16/24.
//

import Foundation
// UserSession.swift

class UserSession {
    // Shared instance (유일한 인스턴스)
    static let shared = UserSession()
    
    // private init으로 외부에서 인스턴스를 생성하지 못하도록 막음
    private init() {}
    
    // userId를 저장할 변수
    var userId: String = ""
}
