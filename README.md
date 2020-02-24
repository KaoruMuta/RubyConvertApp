# RubyConvertApp
読み方がわからない単語の読み方を教えてくれるシンプルなアプリ

# Architecture
MVVMを採用．現状はViewModelに通信の処理を任せ，ModelはAPIのレスポンスの型を持っている

# 利用ライブラリ
- RxSwift(https://github.com/ReactiveX/RxSwift)
- RxCocoa(https://github.com/ReactiveX/RxSwift)
- Moya(https://github.com/Moya/Moya)

# APIに関して
こちらgooAPIを利用しています（https://labs.goo.ne.jp/api/jp/hiragana-translation/）

もしフィードバック等ありましたら，PRにてお願いします！
