//
//  RecoverPasswordViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/18/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class RecoverPasswordViewController: LoaderBaseViewController {
    var headerView = HeaderView(topLabelText: "Восстановление пароля".localized(), subLabelText: "Чтобы получить код для восстановления пароля, введите пожалуйста номер телефона, по которому создавали аккаунт".localized())
    var phoneInputView = InputView(inputType: .phone, placeholder: "", righticon: nil, topLabelText: "Номер телефона".localized())
    var nextButton = MainButton(title: "Далее".localized())
    var registerLabel = Label(title: "Нет аккаунта?".localized(), type: .Regular)
    var registerButton = BlueButton(title: "Создать сейчас".localized())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
    }
    func setupAction(){
        nextButton.action = {
            self.navigationController?.pushViewController(CodeConfirmationViewController(), animated: true)
        }
        registerButton.action = {
            self.navigationController?.pushViewController(RegistrationViewController(), animated: true)

        }
    }
    func setupView(){
        view.backgroundColor = .white
        contentView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(AppConstants.screenHeight / 3)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        contentView.addSubview(phoneInputView)
        phoneInputView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(80)
            make.left.right.equalTo(headerView)
            make.height.equalTo(68)
        }
        contentView.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.top.equalTo(phoneInputView.snp.bottom).offset(88)
            make.height.equalTo(52)
            make.left.right.equalTo(headerView)
        }
        contentView.addSubview(registerLabel)
        registerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nextButton.snp.bottom).offset(20)
            make.left.equalTo(68)
           
        }
        contentView.addSubview(registerButton)
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(registerLabel)
            make.left.equalTo(registerLabel.snp.right).offset(2)
            make.height.equalTo(16)
            make.width.equalTo(120)
            make.bottom.equalTo(-10)
        }
        
        
    }
    
}
