//
//  RegistrationViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/11/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit


class RegistrationViewController: LoaderBaseViewController {
    
    private var viewModel = RegisterViewModel()
    
    
    private var pickerArray = ["Клиент", "Продавец"]
    
    var cityList: [AddingDataListModel] = [] {
        didSet {
            cityInputView.valueList = cityList.map({$0.name})
        }
    }


    
    var headerView = HeaderView(topLabelText: "Регистрация".localized(), subLabelText: "Введите ваши данные, чтобы создать персональный аккаунт".localized())
    var phoneInputView = InputView(inputType: .phone, placeholder: "", topLabelText: "Номер телефона".localized())
    var nameInputIView = InputView(inputType: .plainText, placeholder: "Как вас зовут?".localized(), topLabelText: "Имя".localized())
    var cityInputView = InputView(inputType: .plainText, placeholder: "Из какого вы города?".localized(), righticon: #imageLiteral(resourceName: "Vector-1"), topLabelText: "Город".localized(), isPicker: true)

    var passwordInputView = InputView(inputType: .secureText, placeholder: "Придумайте пароль".localized(), righticon: #imageLiteral(resourceName: "Group"), topLabelText: "Введите пароль".localized())
    var registrationType = InputView(inputType: .plainText, placeholder: "Выберите тип пользования".localized(),righticon: #imageLiteral(resourceName: "Vector"), topLabelText: "Тип пользования".localized(), isPicker: true)

    var createAccountButton = MainButton(title: "Создать аккаунт".localized())
    var policyLabel = PrivacyLabel(selectedColor: #colorLiteral(red: 0.1450980392, green: 0.4509803922, blue: 0.8352941176, alpha: 1), deselectedColor: #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1), aligment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLoaderView()
        setupAction()
        setupPicker()
        getCityList()
        setupInputViewsData()
    }
    
    func setupPicker(){
        registrationType.pickerView.delegate = self
        registrationType.pickerView.dataSource = self
    }
    
    private func setupInputViewsData() {
        cityInputView.pickerSelectBlock = { [weak self] index in
            guard let `self` = self else { return }
            guard index != -1 else { self.viewModel.setCity(""); return}
            self.viewModel.setCity("\(self.cityList[index].id)")
        }

    }


    
    func setupAction(){
        
        passwordInputView.iconAction = { [weak self] in
             self?.passwordInputView.textField.isSecureTextEntry.toggle()
              (self?.passwordInputView.textField.isSecureTextEntry)! ? (self?.passwordInputView.rightIconView.image = #imageLiteral(resourceName: "Group")) : (self?.passwordInputView.rightIconView.image = #imageLiteral(resourceName: "eye crossed"))
        }                                    
        
        createAccountButton.action = { [unowned self] in
            self.tapLogReg()
        }
    }

    func setupView(){
        self.view.backgroundColor = .white
        contentView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(88)
            make.left.equalTo(16)
            make.right.equalTo(-60)
        }
        contentView.addSubview(phoneInputView)
        phoneInputView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(32)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(68)
        }
        contentView.addSubview(nameInputIView)
        nameInputIView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneInputView.snp.bottom).offset(12)
            make.height.left.right.equalTo(phoneInputView)
        }
        contentView.addSubview(cityInputView)
        cityInputView.snp.makeConstraints { (make) in
            make.top.equalTo(nameInputIView.snp.bottom).offset(12)
            make.height.left.right.equalTo(phoneInputView)
        }
        contentView.addSubview(passwordInputView)
        passwordInputView.snp.makeConstraints { (make) in
            make.top.equalTo(cityInputView.snp.bottom).offset(12)
            make.height.left.right.equalTo(phoneInputView)
        }
        contentView.addSubview(registrationType)
        registrationType.snp.makeConstraints { (make) in
            make.top.equalTo(passwordInputView.snp.bottom).offset(12)
            make.height.left.right.equalTo(phoneInputView)
        }
        contentView.addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(registrationType.snp.bottom).offset(40)
            make.left.right.equalTo(registrationType)
            make.height.equalTo(52)
        }
        contentView.addSubview(policyLabel)
        policyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(createAccountButton.snp.bottom).offset(12)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.lessThanOrEqualTo(-12)
        }
        
    }
    
    @objc func tapLogReg() -> Void {
        signUP()

    }

}

extension RegistrationViewController {
    private func signUP() -> Void {
        viewModel.setPhone(phoneInputView.phoneTextField.text!.replacingOccurrences(of: "-", with: ""))

//        viewModel.setPhone(phoneInputView.phoneTextField.text!)
        viewModel.setName(nameInputIView.textField.text!)
        viewModel.setPassword(passwordInputView.textField.text!)
        viewModel.setType( registrationType.pickerView.selectedRow(inComponent: 0) == 1 ? "USER" : "SELLER")
        

        guard viewModel.isValid() else {self.showErrorMessage(messageType: .none, viewModel.errorMessage); return}
        var parameters = viewModel.getParameters()
        showLoader()
        if UserManager.getFirebaseToken() != nil{
        parameters!["device_token"] = UserManager.getFirebaseToken()!
        parameters!["device_type"] = "ios"
        }
        
        ParseManager.shared.postRequest(url: AppConstants.API.register, parameters: parameters, success: { (result: User?) in
            self.hideLoader()
            self.showDissmissAlert(title: "Вы успешно зарегистрировались!", message: "Войдите используя номер телефона и пароль") {
                self.navigationController?.pushViewController(LoginPageViewController(), animated: true)
            }

            
//            UserManager.shared.createSession(withUser: result!)
//            AppCenter.shared.makeRootController()
        }) { (error) in
            self.showErrorMessage(messageType: .error, error)
        }

    }
    
    private func getCityList() {
        ParseManager.shared.getRequest(url: AppConstants.API.getCities, success: { (result: [AddingDataListModel]) in
            self.cityList = result
            self.hideLoader()
        }) { (error) in
            self.showErrorMessage(error)
        }

    }

}

extension RegistrationViewController : UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        registrationType.textField.text = pickerArray[row]
    }
    

    
    
}
