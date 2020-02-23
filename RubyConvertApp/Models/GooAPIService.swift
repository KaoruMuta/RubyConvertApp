//
//  GooAPIService.swift
//  RubyConvertApp
//
//  Created by k_muta on 2020/02/21.
//  Copyright © 2020 muta. All rights reserved.
//

import Foundation
import Moya

final class GooAPIService {
    
    static let shared = GooAPIService()
    
    public func fetch(sentence: String) {
        let provider = MoyaProvider<GooAPI>()
        provider.request(.search(request: ["app_id": Parameters.applicationId, "sentence": sentence, "output_type": Parameters.outputType])) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSONDecoder().decode(ConvertedResult.self, from: response.data) else { return }
                dump(jsonData)
            case let .failure(error):
                print(error)
            }
        }
    }
}
