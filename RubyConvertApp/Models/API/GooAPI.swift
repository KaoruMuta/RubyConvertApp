//
//  GooAPI.swift
//  RubyConvertApp
//
//  Created by k_muta on 2020/02/21.
//  Copyright © 2020 muta. All rights reserved.
//

import Foundation
import Moya

enum GooAPI {
    case search(request: Dictionary<String, Any>)
}

extension GooAPI: TargetType {
    var baseURL: URL {
        return URL(string: Parameters.baseURL)!
    }
    
    var path: String {
        switch self {
        case .search:
            return Parameters.requestPath
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let request):
            return .requestParameters(parameters: request, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
}
