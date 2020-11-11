//
//  ProfileViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit
import Kingfisher
class ProfileViewController: LoaderBaseViewController {
    
    private var viewModel = EditViewModel()

    var navBar = NavigationBar(title: "", leftButtonImage: #imageLiteral(resourceName: "Group-1"))
    var switcher = SwitcherView(firstTitle: "Покупатель".localized(), secondTitle: "Продавец".localized())
    var infoLabel = Label(title: "В этом режиме Вы ищете авто-запчасти или услуги".localized(), type: .Medium, aligment: .center)
    var profileView = ProfileMainView()
    var tableView = UITableView()
    var sectionNamesArray = ["Изменить данные".localized,"Сменить пароль".localized,"Изменить язык".localized,"Уведомления".localized,"Звук".localized,"О приложении".localized]
    var sectionIconsArray: [UIImage] = [#imageLiteral(resourceName: "Group 32"),#imageLiteral(resourceName: "Group 43"),#imageLiteral(resourceName: "Group 32-1"),#imageLiteral(resourceName: "Group 32-2"),#imageLiteral(resourceName: "speaker 1"),#imageLiteral(resourceName: "Group 32-3")]
    var exitView = ExitView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        setupAction()
        setupData()
        setUserType()
        
        if !UserManager.shared.isSeller(){
            switcher.firstButtonSelected()
        }
        else {
            switcher.secondButtonSelected()
        }

    }
    func setupAction(){
        navBar.leftButtonAction = {
             self.sideMenuController?.showLeftViewAnimated()
        }
        
        switcher.firstAction = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.setType("USER")

            self.infoLabel.text = "В этом режиме Вы ищете авто-запчасти или услуги"

            self.tapType()

        }
        
        switcher.secondAction = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.setType("SELLER")
            self.infoLabel.text = "В этом режиме Вы принимаете заказы в качестве продавца"

            self.tapType()

        }


        
    }
    
    private func setupData(){
        if let user = UserManager.shared.getCurrentUser() {
            if let user = user.user {
                profileView.nameLabel.text = user.name
                profileView.locationLabel.text = user.city_id
                if let url = user.avatar?.url{
                    profileView.profileImageView.kf.setImage(with: url)
                }


            }
            
        }


    }
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.cellIdentifier())
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
    }
    func setupViews(){
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo( AppConstants.totalNavBarHeight)
        }
        contentView.addSubview(switcher)
        switcher.snp.makeConstraints { (make) in
            make.top.equalTo(AppConstants.totalNavBarHeight - 10)
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.height.equalTo(48)
        }
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(1.5 * AppConstants.totalNavBarHeight + 36)
            make.left.equalTo(60)
            make.right.equalTo(-60)
        }
        contentView.addSubview(profileView)
        profileView.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(profileView.snp.bottom).offset(27)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(350)
        }
        contentView.addSubview(exitView)
        exitView.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom).offset(24)
            make.left.right.equalTo(tableView)
            make.height.equalTo(48)
            make.bottom.equalTo(-69)
        }
    }
    
    private func tapType() -> Void {
        setUserType()

    }

}
extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.cellIdentifier(), for: indexPath) as! ProfileTableViewCell
            cell.selectionStyle = .none
            cell.sectionNameLabel.text = sectionNamesArray[indexPath.row]()
            cell.iconImageView.image = sectionIconsArray[indexPath.row]
        
        if indexPath.row == 5{
            cell.borderView.isHidden = true
        }
        cell.setupCell(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(EditProfileViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(ChangePasswordViewController(), animated: true)
        case 2:
            navigationController?.pushViewController(ChangeLanguageViewController(), animated: true)
        case 5:
            navigationController?.pushViewController(PolicyViewController(), animated: true)
        default:
            break
        }
        
    }
    
    
}

extension ProfileViewController {
    
    
    private func setUserType()  {
        
        guard viewModel.isValid() else {self.showErrorMessage(messageType: .none, viewModel.errorMessage); return}
        let parameters = viewModel.getParameters()
        showLoader()
        parameters?.forEach({ (key,value) in
            print("key : \(key)\n")
            print("value : \(value)\n\n")
        })
    
        ParseManager.shared.multipartFormData(url: AppConstants.API.editProfile, parameters: parameters, success: { (result: User) in
            
//            self.profileView.nameLabel.text = result.user?.name
//            self.profileView.locationLabel.text = result.user?.city_id
//            if let url = result.user?.avatar?.url{
//                self.profileView.profileImageView.kf.setImage(with: url)
//            }
            
            let user: User? = User(token: UserManager.shared.getCurrentUser()?.token, user: result.user)
        UserManager.shared.createSession(withUser: user!)

            
        }) { (error) in
            self.showErrorMessage(messageType: .error, error)
            self.hideLoader()

        }
    }
}
