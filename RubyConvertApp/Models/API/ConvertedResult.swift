//
//  Result.swift
//  RubyConvertApp
//
//  Created by k_muta on 2020/02/23.
//  Copyright © 2020 muta. All rights reserved.
//

import Foundation

struct ConvertedResult: Codable {
    var converted: String
    var output_type: String
    var request_id: String
}
