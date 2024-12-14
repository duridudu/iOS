//
//  MyRouter.swift
//  subway
//
//  Created by 이윤주 on 12/8/24.
//


import Foundation
import Alamofire

// 검색관련 API 관리
enum MyRouter : URLRequestConvertible {
    case searchArrival(term: String)
    case searchUsers(term: String)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL + "subway/")!
    }

    var method: HTTPMethod {
        switch self {
        case .searchArrival, .searchUsers :
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
            // let 넣으니 멀쩡
        case let .searchArrival(term)
            : return API.API_KEY + "json/realtimeStationArrival/0/20/" + term
        case .searchUsers
            : return "users/"
        }
    }
//    
//    var parameters: [String : String]{
//        switch self{
//        case let .searchUsers(term), let .searchArrival(term):
//            return ["query":term]
//        }
//    }
//    
    func asURLRequest() throws -> URLRequest {

        let url = baseURL.appendingPathComponent(endPoint)
        print("MyRouter - asURLRequest() url : \(url)")
        var request = URLRequest(url: url)
        request.method = method
//        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        return request
    }
}


