//
//  CreateNewPasswordViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/18/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class CreateNewPasswordViewController: LoaderBaseViewController {
    var headerView = HeaderView(topLabelText: "Создайте новый пароль".localized(), subLabelText: "Введите 4-х значный код, который мы вам отправили на номер: ".localized())
    var passwordInputView = InputView(inputType: .secureText, placeholder: "Придумайте пароль".localized() , righticon: #imageLiteral(resourceName: "Group"), topLabelText: "Пароль".localized())
    var repeatPasswordInputView = InputView(inputType: .secureText, placeholder: "Повторите пароль".localized() , righticon:  #imageLiteral(resourceName: "Group"), topLabelText: "Пароль".localized())
    var finishButton = MainButton(title: "Завершить".localized())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
    }
    func setupView(){
        view.backgroundColor = .white
        contentView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(AppConstants.screenHeight * 1/3)
        }
        contentView.addSubview(passwordInputView)
        passwordInputView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(32)
            make.left.right.equalTo(headerView)
            make.height.equalTo(68)
        }
        contentView.addSubview(repeatPasswordInputView)
        repeatPasswordInputView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordInputView.snp.bottom).offset(12)
            make.left.right.height.equalTo(passwordInputView)
        }
        contentView.addSubview(finishButton)
        finishButton.snp.makeConstraints { (make) in
            make.top.equalTo(repeatPasswordInputView.snp.bottom).offset(48)
            make.left.right.equalTo(headerView)
            make.height.equalTo(52)
            make.bottom.equalTo(-60)
        }
    }
    func setupAction(){
        finishButton.action = {
            self.navigationController?.popToRootViewController(animated: true)
        }
        passwordInputView.iconAction = { [weak self] in
        self?.passwordInputView.textField.isSecureTextEntry.toggle()
            (self?.passwordInputView.textField.isSecureTextEntry)! ? (self?.passwordInputView.rightIconView.image = #imageLiteral(resourceName: "Group")) : (self?.passwordInputView.rightIconView.image = #imageLiteral(resourceName: "eye crossed"))
         }
        
        repeatPasswordInputView.iconAction = { [weak self] in
        self?.repeatPasswordInputView.textField.isSecureTextEntry.toggle()
            (self?.repeatPasswordInputView.textField.isSecureTextEntry)! ? (self?.repeatPasswordInputView.rightIconView.image = #imageLiteral(resourceName: "Group")) : (self?.repeatPasswordInputView.rightIconView.image = #imageLiteral(resourceName: "eye crossed"))
         }
        
        
    }


}
