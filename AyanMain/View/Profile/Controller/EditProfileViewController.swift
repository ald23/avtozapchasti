//
//  EditProfileViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/14/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

class EditProfileViewController: LoaderBaseViewController {
    
    private var viewModel = EditViewModel()
    
    private var pickerArray = ["Продавец", "Клиент"]
    
    private var cityList: [AddingDataListModel] = [] {
        didSet {
            cityInputView.valueList = cityList.map({$0.name})
        }
    }

    var navBar = NavigationBar(title: "", leftButtonImage: #imageLiteral(resourceName: "feather_chevron-left"))
    
    var profileImage : UIImageView = {
        var image = UIImageView()
            image.image = #imageLiteral(resourceName: "Group 32")
            image.layer.cornerRadius = 60
            image.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            image.clipsToBounds = true
        
        return image
    }()
    
    lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker(presentationController: self, delegate: self)
        return imagePicker
    }()

    var uploadPhotoButton : UIButton  = {
        var button = UIButton()
        let atr : [NSAttributedString.Key : Any] =  [NSAttributedString.Key.foregroundColor:   #colorLiteral(red: 0.1450980392, green: 0.4509803922, blue: 0.8352941176, alpha: 1),
                                                     NSAttributedString.Key.font: UIFont.getMontserratMedium(of: 12),NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor : #colorLiteral(red: 0.1450980392, green: 0.4509803922, blue: 0.8352941176, alpha: 1)]
        let atributedTitle = NSAttributedString(string: "Загрузить фото".localized(), attributes: atr)
            button.setAttributedTitle(atributedTitle, for: .normal)
        button.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        return button
    }()
    
    var phoneInputView = InputView(inputType: .phone, placeholder: "",  topLabelText: "Номер телефона".localized())
    var nameInputView = InputView(inputType: .plainText, placeholder: "", topLabelText: "Имя".localized())
    var cityInputView = InputView(inputType: .plainText, placeholder: "Выберите город", righticon: #imageLiteral(resourceName: "Vector-1"), topLabelText: "Город".localized(), isPicker: true)
    var userTypeInputView = InputView(inputType: .plainText, placeholder: "Выберите тип пользования".localized(), righticon: #imageLiteral(resourceName: "Vector-1"), topLabelText: "Тип пользования", isPicker: true)
    var saveButton = MainButton(title: "Сохранить".localized())
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        setupData()
        setupLoaderView()
        setupPicker()
        setupInputViewsData()
        getCityList()
    }
    func setupPicker(){
        userTypeInputView.pickerView.delegate = self
        userTypeInputView.pickerView.dataSource = self
    }
    func setupAction(){
        navBar.leftButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        saveButton.action = { [weak self] in
            guard let `self` = self else { return }
            self.tapEdit()
        }


    }
        

    
    private func setupData() {
        if let user = UserManager.shared.getCurrentUser() {
            if let user = user.user {
                nameInputView.textField.text = user.name
                phoneInputView.phoneTextField.text = user.phone
                cityInputView.textField.text = user.city_id
                profileImage.kf.setImage(with: user.avatar?.serverUrlString.asUrl)!
            }
        }
    }
    
    
    private func setupInputViewsData() {
        cityInputView.pickerSelectBlock = { [weak self] index in
            guard let `self` = self else { return }
            guard index != -1 else { self.viewModel.setCity(""); return}
            self.viewModel.setCity("\(self.cityList[index].id)")
        }

    }
    

    func setupView(){
        self.view.backgroundColor = .white
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(AppConstants.totalNavBarHeight)
        }
        addSubview(profileImage)
        profileImage.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(14)
            make.width.height.equalTo(120)
            make.centerX.equalToSuperview()
        }
        addSubview(uploadPhotoButton)
        uploadPhotoButton.snp.makeConstraints { (make) in
            make.top.equalTo(profileImage.snp.bottom).offset(4)
            make.width.equalTo(100)
            make.height.equalTo(15)
            make.centerX.equalToSuperview()
        }
        addSubview(phoneInputView)
        phoneInputView.snp.makeConstraints { (make) in
            make.top.equalTo(uploadPhotoButton.snp.bottom).offset(33)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(68)
        }
        addSubview(nameInputView)
        nameInputView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneInputView.snp.bottom).offset(11)
            make.left.right.height.equalTo(phoneInputView)
        }
        addSubview(cityInputView)
        cityInputView.snp.makeConstraints { (make) in
            make.top.equalTo(nameInputView.snp.bottom).offset(11)
            make.left.right.height.equalTo(phoneInputView)
        }
        addSubview(userTypeInputView)
        userTypeInputView.snp.makeConstraints { (make) in
            make.top.equalTo(cityInputView.snp.bottom).offset(11)
            make.left.right.height.equalTo(phoneInputView)
        }
        addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(userTypeInputView.snp.bottom).offset(64)
            make.left.right.equalTo(phoneInputView)
            make.height.equalTo(52)
        }
    }
    
    private func tapEdit() -> Void {
        edit()

    }
    
    @objc private func openImagePicker() -> Void {
        imagePicker.present(from: view)
    }


}


//  MARK: - image picker delegate
extension EditProfileViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        profileImage.image = image
    }
}


extension EditProfileViewController {
    private func edit() -> Void {
//        viewModel.setPhone(phoneInputView.phoneTextField.text!)
        
      //  viewModel.setPhoto(())!)
        viewModel.setName(nameInputView.textField.text!)
        viewModel.setType(userTypeInputView.pickerView.selectedRow(inComponent: 0) == 1 ? "USER" : "SELLER")

//        guard viewModel.isValid() else {self.showErrorMessage(messageType: .none, viewModel.errorMessage); return}
        var parameters = viewModel.getParameters()
        
        showLoader()
        if let image = profileImage.image?.jpegData(compressionQuality: 0.8){
            parameters!["avatar"] = image
        }
        ParseManager.shared.multipartFormData(url: AppConstants.API.editProfile, parameters: parameters, success: { (result: User?) in
            self.hideLoader()
            
            let user: User? = User(token: UserManager.shared.getCurrentUser()?.token, user: result?.user)
            UserManager.shared.createSession(withUser: user!)
            (self.sideMenuController?.leftViewController as! SlideMenuViewController).setupData()
            self.navigationController?.pushViewController(MainPageViewController(), animated: true)
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
extension EditProfileViewController : UIPickerViewDelegate , UIPickerViewDataSource{
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
        userTypeInputView.textField.text = pickerArray[row]
    }
    

    
    
}
