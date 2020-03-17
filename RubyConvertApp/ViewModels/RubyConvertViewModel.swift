//
//  RubyConvertViewModel.swift
//  RubyConvertApp
//
//  Created by k_muta on 2020/02/21.
//  Copyright © 2020 muta. All rights reserved.
//

import Moya
import RxSwift
import RxRelay

final class RubyConvertViewModel {
    
    private let disposeBag = DisposeBag()
    let convertedWord = BehaviorRelay<String>(value: "")
    
    // 本当はModel側で描きたかったが，ViewModelに今回APIの処理を記入している（提出時間間近のため今後アップデートしていく）
    public func fetchDataWithInputWord(sentence: String) {
        let provider = MoyaProvider<GooAPI>()
        
        provider.rx
            .request(.search(request: ["app_id": Parameters.applicationId, "sentence": sentence, "output_type": Parameters.outputType]))
            .map{ (response) -> ConvertedResult? in
                return try? JSONDecoder().decode(ConvertedResult.self, from: response.data)
            }.subscribe(onSuccess: { (response) in
                guard let convertedWord = response?.converted else { return }
                self.convertedWord.accept(convertedWord)
            }, onError: { (error) in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    public func clearText() {
        convertedWord.accept("")
    }
    
    
}
