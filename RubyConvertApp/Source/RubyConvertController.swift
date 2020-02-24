//
//  RubyConvertController.swift
//  RubyConvertApp
//
//  Created by k_muta on 2020/02/21.
//  Copyright © 2020 muta. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class RubyConvertController: UIViewController {
    
    @IBOutlet private weak var explanationLabel: UILabel!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var entryField: UITextField!
    @IBOutlet private weak var confirmButton: UIButton!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var licenseImageView: UIImageView!
    
    fileprivate let viewModel = RubyConvertViewModel()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureObserver()
    }
    
    private func bind() {
        viewModel.convertedWord
            .asObservable()
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .subscribe { [unowned self] _ in
                guard let inputWord = self.entryField.text else { return }
                self.viewModel.fetchDataWithInputWord(sentence: inputWord)
            }.disposed(by: disposeBag)
        
        clearButton.rx.tap
            .subscribe { [unowned self] _ in
                self.viewModel.convertedWord.accept("")
                self.entryField.text = ""
            }.disposed(by: disposeBag)
    }
    
    private func setUI() {
        entryField.delegate = self
        explanationLabel.text = Message.explanation
        resultLabel.text = ""
        licenseImageView.setImageByURL(url: Resources.licenseImageUrl)
    }

    private func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                 name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                 name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification?) {
        guard let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            let transform = CGAffineTransform(translationX: 0, y: -(rect.size.height))
            self.view.transform = transform
        }
    }

    @objc func keyboardWillHide(_ notification: Notification?) {
        guard let duration = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            self.view.transform = CGAffineTransform.identity
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension RubyConvertController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
