//
//  RubyConvertController.swift
//  RubyConvertApp
//
//  Created by k_muta on 2020/02/21.
//  Copyright © 2020 muta. All rights reserved.
//

import UIKit

class RubyConvertController: UIViewController {
    
    private let service = GooAPIService.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        service.fetch(sentence: "楽しかったインターン生活")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
