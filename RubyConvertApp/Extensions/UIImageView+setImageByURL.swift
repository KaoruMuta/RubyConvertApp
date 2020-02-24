//
//  UIImageView+setImageByURL.swift
//  RubyConvertApp
//
//  Created by k_muta on 2020/02/24.
//  Copyright © 2020 muta. All rights reserved.
//

import UIKit

extension UIImageView {
    public func setImageByURL(url: String) {
        guard let imageURL = URL(string: url), let imageData = try? Data(contentsOf: imageURL) else { return }
        self.image = UIImage(data: imageData)
    }
}
