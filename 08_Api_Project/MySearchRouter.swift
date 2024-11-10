//
//  MySearchRouter.swift
//  08_Api_Project
//
//  Created by 이윤주 on 10/26/24.
//

import Foundation
import Alamofire

// 검색관련 API 관리
enum MySearchRouter : URLRequestConvertible {
    case searchPhotos(term: String)
    case searchUsers(term: String)

    var baseURL: URL {
        return URL(string: API.BASE_URL + "search/")!
    }

    var method: HTTPMethod {
        switch self {
        case .searchPhotos, .searchUsers :
            return .get
        }
//        switch self {
//        // searchPhotos면 get으로 하겠다
//        case .searchPhotos:
//            return .get
//        case .searchUsers:
//            return .post
//        }
    }

    var endPoint: String {
        switch self {
        case .searchPhotos
            : return "photos/"
        case .searchUsers
            : return "users/"
        }
    }
    
    var parameters: [String : String]{
        switch self{
        case let .searchUsers(term), let .searchPhotos(term):
            return ["query":term]
        }
    }
    
    func asURLRequest() throws -> URLRequest {

        let url = baseURL.appendingPathComponent(endPoint)
        print("MySearchRouter - asURLRequest() url : \(url)")
        var request = URLRequest(url: url)
        request.method = method
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        return request
    }
}


