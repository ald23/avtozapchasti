//
//  ChangePasswordViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/14/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class ChangePasswordViewController: LoaderBaseViewController {
    
    private var viewModel = ChangePasswordViewModel()

    var navBar = NavigationBar(title: "", rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "feather_chevron-left"))
    var mainLabel = Label(title: "Смена пароля".localized(), type: .Bold, textSize: 27)

    var oldPasswordInputView = InputView(inputType: .secureText, placeholder: "", righticon: #imageLiteral(resourceName: "Group"), topLabelText: "Введите старый пароль".localized())
    var newPasswordInputView = InputView(inputType: .secureText, placeholder: "", righticon: #imageLiteral(resourceName: "Group"), topLabelText: "Введите новый пароль".localized())
    var repeatPassword = InputView(inputType: .secureText, placeholder: "", righticon: #imageLiteral(resourceName: "Group"), topLabelText: "Подтвердите новый пароль".localized())
    var saveButton = MainButton(title: "Сохранить".localized())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        setupLoaderView()
    }
    func setupAction(){
        navBar.leftButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        saveButton.action = { [unowned self] in
            self.tapPassword()
        }

        
        oldPasswordInputView.iconAction = { [weak self] in
            self?.oldPasswordInputView.textField.isSecureTextEntry.toggle()
            (self?.oldPasswordInputView.textField.isSecureTextEntry)! ? (self?.oldPasswordInputView.rightIconView.image = #imageLiteral(resourceName: "Group")) : (self?.oldPasswordInputView.rightIconView.image = #imageLiteral(resourceName: "eye crossed"))
        }
        newPasswordInputView.iconAction = { [weak self] in
             self?.newPasswordInputView.textField.isSecureTextEntry.toggle()
             (self?.oldPasswordInputView.textField.isSecureTextEntry)! ? (self?.newPasswordInputView.rightIconView.image = #imageLiteral(resourceName: "Group")) : (self?.newPasswordInputView.rightIconView.image = #imageLiteral(resourceName: "eye crossed"))
         }
        repeatPassword.iconAction = { [weak self] in
             self?.repeatPassword.textField.isSecureTextEntry.toggle()
             (self?.repeatPassword.textField.isSecureTextEntry)! ? (self?.repeatPassword.rightIconView.image = #imageLiteral(resourceName: "Group")) : (self?.repeatPassword.rightIconView.image = #imageLiteral(resourceName: "eye crossed"))
         }

    }
    

    func setupView(){
        view.backgroundColor = .white
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(AppConstants.totalNavBarHeight)
        }
        contentView.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { (make) in
            make.top.equalTo(200)
            make.left.equalTo(15)
        }
        contentView.addSubview(oldPasswordInputView)
        oldPasswordInputView.snp.makeConstraints { (make) in
            make.top.equalTo(mainLabel.snp.bottom).offset(80)
            make.height.equalTo(68)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        contentView.addSubview(newPasswordInputView)
        newPasswordInputView.snp.makeConstraints { (make) in
            make.top.equalTo(oldPasswordInputView.snp.bottom).offset(12)
            make.left.right.height.equalTo(oldPasswordInputView)
        }
        contentView.addSubview(repeatPassword)
        repeatPassword.snp.makeConstraints { (make) in
            make.top.equalTo(newPasswordInputView.snp.bottom).offset(12)
            make.left.right.height.equalTo(oldPasswordInputView)
        }
        contentView.addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(repeatPassword.snp.bottom).offset(80)
            make.left.right.equalTo(oldPasswordInputView)
            make.height.equalTo(52)
            make.bottom.equalTo(-118)
        }
        
        
    }

    private func tapPassword() -> Void {
        changePassword()

    }

}

extension ChangePasswordViewController {
    private func changePassword() -> Void {
//        viewModel.setPhone(phoneInputView.phoneTextField.text!)
        viewModel.setPasswordOld(oldPasswordInputView.textField.text!)
        viewModel.setPasswordNew(newPasswordInputView.textField.text!)
        viewModel.setPasswordConfirm(repeatPassword.textField.text!)

        guard viewModel.isValid() else {self.showErrorMessage(messageType: .none, viewModel.errorMessage); return}
        let parameters = viewModel.getParameters()
        showLoader()

        ParseManager.shared.postRequest(url: AppConstants.API.editProfile, parameters: parameters, success: { (result: User?) in
            
            let user: User? = User(token: UserManager.shared.getCurrentUser()?.token, user: result?.user)
            UserManager.shared.createSession(withUser: user!)
            self.navigationController?.pushViewController(MainPageViewController(), animated: true)
        }) { (error) in
            self.showErrorMessage(messageType: .error, error)
            self.hideLoader()

        }

    }
}

