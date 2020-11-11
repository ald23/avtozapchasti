//
//  ViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/10/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit



class LoginPageViewController: LoaderBaseViewController {
    
    private var viewModel = LoginViewModel()

    
    var headerView = HeaderView(topLabelText: "Вход".localized(), subLabelText: "Введите ваши данные".localized())
    
    var phoneInput = InputView(inputType: .phone, placeholder: "", righticon: nil,topLabelText: "Номер телефона".localized())
    
    var passwordInput = InputView(inputType: .secureText, placeholder: "", righticon: #imageLiteral(resourceName: "Group"),topLabelText: "Введите пароль".localized())
    var enterButton = MainButton(title: "Войти".localized())
    
    var recoverPasswordButton = BlueButton(title: "Восстановить".localized())
    var reconverPasswordLabel = Label(title: "Забыли пароль?".localized(), type: .Regular)
    var registerLabel = Label(title: "Нет аккаунта?".localized(), type: .Regular)
    var registerButton = BlueButton(title: "Создать сейчас".localized())
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAction()
        setupLoaderView()
    }
    
    func setupAction(){
        enterButton.action = {
            self.tapLogReg()
//          self.navigationController?.pushViewController(MainPageViewController(), animated: true)

//            AppCenter.shared.setRootMainPageViewController()
        }
        recoverPasswordButton.action = {
            self.navigationController?.pushViewController(RecoverPasswordViewController(), animated: true)
        }
        passwordInput.iconAction = { [weak self] in
            self?.passwordInput.textField.isSecureTextEntry.toggle()
            (self?.passwordInput.textField.isSecureTextEntry)! ? (self?.passwordInput.rightIconView.image = #imageLiteral(resourceName: "Group")) : (self?.passwordInput.rightIconView.image = #imageLiteral(resourceName: "eye crossed"))
         }
        
        registerButton.action = {[unowned self] in
            self.navigationController?.pushViewController(RegistrationViewController(), animated: true)
        }
    }
    func setupViews(){
        view.backgroundColor = .white
        contentView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(240)
        }
        contentView.addSubview(phoneInput)
        phoneInput.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(80)
            make.left.equalTo(headerView)
            make.right.equalTo(-16)
            make.height.equalTo(68)
        }

        contentView.addSubview(passwordInput)
        passwordInput.snp.makeConstraints { (make) in
            make.top.equalTo(phoneInput.snp.bottom).offset(8)
            make.left.right.height.equalTo(phoneInput)
        }
        contentView.addSubview(recoverPasswordButton)
        recoverPasswordButton.snp.makeConstraints { (make) in
            make.right.equalTo(phoneInput)
            make.width.equalTo(100)
            make.height.equalTo(16)
            make.top.equalTo(passwordInput.snp.bottom).offset(8)
        }
        contentView.addSubview(reconverPasswordLabel)
        reconverPasswordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(recoverPasswordButton)
            make.right.equalTo(recoverPasswordButton.snp.left).offset(2)
        }
        contentView.addSubview(enterButton)
        enterButton.snp.makeConstraints { (make) in
            make.top.equalTo(reconverPasswordLabel.snp.bottom).offset(88)
            make.left.right.equalTo(phoneInput)
            make.height.equalTo(48)
        }
        
        contentView.addSubview(registerLabel)
        registerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(enterButton.snp.bottom).offset(20)
            make.left.equalTo(68)
        }
        contentView.addSubview(registerButton)
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(registerLabel)
            make.left.equalTo(registerLabel.snp.right).offset(2)
            make.height.equalTo(recoverPasswordButton)
            make.width.equalTo(120)
            make.bottom.equalTo(-20)
        }

    }
    
    @objc func tapLogReg() -> Void {
        signin()
        
    }


}


//  MARK: - parcel
extension LoginPageViewController {
    private func signin() -> Void {
        viewModel.setPhone(phoneInput.phoneTextField.text!)
        viewModel.setPassword(passwordInput.textField.text!)

        
        guard viewModel.isValid() else {self.showErrorMessage(messageType: .none, viewModel.errorMessage); return}
        var parameters = viewModel.getParameters()
        showLoader()
        if UserManager.getFirebaseToken() != nil{
        parameters!["device_token"] = UserManager.getFirebaseToken()!
        parameters!["device_type"] = "ios"
        }

        
        ParseManager.shared.postRequest(url: AppConstants.API.login, parameters: parameters, success: { (result: User?) in
            UserManager.shared.createSession(withUser: result!)
            AppCenter.shared.makeRootController()
        }) { (error) in
            self.showErrorMessage(messageType: .error, error)
            self.hideLoader()

        }
//            let vc = MainPageViewController()
//            self.navigationController?.pushViewController(vc, animated: true)

    }
}
//


