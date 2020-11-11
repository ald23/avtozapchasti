//
//  SlideMenuViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/10/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class SlideMenuViewController : LoaderBaseViewController{
    
    private var viewModel = EditViewModel()

    
    var menuButton : UIButton = {
        var button = UIButton()
            button.setImage(#imageLiteral(resourceName: "Group-1"), for: .normal)
        
        return button
    }()
    var switcher = SwitcherView(firstTitle: "Клиент".localized(), secondTitle: "Продавец".localized())
    var infoLabel = Label(title: "В этом режиме Вы ищете авто-запчасти или услуги".localized(), type: .Medium)
    var avatarView = AvatarView()
    var tableView = UITableView()
    var sectionNamesArray = ["Главная".localized,"Мои объявления".localized,"Мои уведомления".localized,"Тарифы".localized]
    lazy var viewControllersArray = [MainPageViewController(),MyPostsViewController(),NotificationsViewController(),TarriffViewController()]
    
    var imagesArray : [UIImage] = [#imageLiteral(resourceName: "house"),#imageLiteral(resourceName: "clipboard 1"),#imageLiteral(resourceName: "Group-2"),#imageLiteral(resourceName: "coupon")]
    
    var exitImageView : UIImageView = {
        var image = UIImageView()
            image.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
            image.image = #imageLiteral(resourceName: "Group-3")
            image.layer.cornerRadius = 20
            image.contentMode = .center
        
        return image
    }()
    var exitLabel = Label(title: "Сменить аккаунт".localized(), type: .Medium, textSize: 15)

        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupviews()
        setupTableView()
        setupAction()
        let tap = UITapGestureRecognizer(target: self, action: #selector(SlideMenuViewController.tapFunction))
        exitLabel.isUserInteractionEnabled = true
        exitLabel.addGestureRecognizer(tap)

        if !UserManager.shared.isSeller(){
            switcher.firstButtonSelected()
        }
        else {
            switcher.secondButtonSelected()
            viewControllersArray = [MainPageViewController(),MainPageViewController(),NotificationsViewController(),TarriffViewController()]

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
//        navigationController?.pushViewController(LoginPageViewController(), animated: true)
        UserManager.shared.deleteCurrentSession()
        AppCenter.shared.makeRootController()
    }
    
    
    private func setupAction(){
        
        avatarView.action = {
            self.sideMenuController?.hideLeftView(animated: true, completionHandler: {
                self.sideMenuController?.rootViewController = ProfileViewController().inNavigation()
            })
        }
        
        switcher.firstAction = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.setType("USER")
            self.avatarView.roleLabel.text = "Клиент"
            self.infoLabel.text = "В этом режиме Вы ищете авто-запчасти или услуги"
            self.tapType()
            UserManager.shared.setUserSeller(isExecute: false)
            self.sideMenuController?.hideLeftView(animated: true, completionHandler: {
                AppCenter.shared.start()
            })
        }
        
        switcher.secondAction = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.setType("SELLER")
            self.avatarView.roleLabel.text = "Продавец"
            self.infoLabel.text = "В этом режиме Вы принимаете заказы в качестве продавца"
            self.tapType()
            UserManager.shared.setUserSeller(isExecute: true)
            
            self.sideMenuController?.hideLeftView(animated: true, completionHandler: {
                AppCenter.shared.start()
            })

        }
       

    }
    
    func setupData(){
        if let user = UserManager.shared.getCurrentUser() {
            if let user = user.user {
                avatarView.nameLabel.text = user.name
//                avatarView.roleLabel.text = user.type
                if let url = user.avatar?.url{
                    avatarView.profileImage.kf.setImage(with: url)
                }

            }
            
        }
    }

    private func setupTableView(){
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SlideMenuTableViewCell.self, forCellReuseIdentifier: SlideMenuTableViewCell.cellIdentifier())
        tableView.isScrollEnabled = false
    }
    private func setupviews(){
        self.view.backgroundColor = .white
        contentView.addSubview(menuButton)
        menuButton.snp.makeConstraints { (make) in
            make.top.equalTo(70)
            make.right.equalTo(-16)
            make.width.height.equalTo(20)
        }
        contentView.addSubview(switcher)
        switcher.snp.makeConstraints { (make) in
            make.top.equalTo(menuButton.snp.bottom).offset(26)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(40)
        }
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(switcher.snp.bottom).offset(12)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-30)
            make.top.equalTo(infoLabel.snp.bottom).offset(28)
        }
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(avatarView.snp.bottom).offset(48)
            make.left.right.equalToSuperview()
            make.height.equalTo(208)
        }
        contentView.addSubview(exitImageView)
        exitImageView.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom).offset(100)
            make.left.equalTo(16)
            make.width.height.equalTo(40)
        }
        contentView.addSubview(exitLabel)
        exitLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(exitImageView)
            make.left.equalTo(exitImageView.snp.right).offset(12)
            make.bottom.equalTo(-20)
        }
        
    }
    
    private func tapType() -> Void {
        setUserType()

    }

    func moveToPage(page : UIViewController){
        sideMenuController?.hideLeftView(animated: true, completionHandler: {
            self.sideMenuController?.rootViewController = page.inNavigation()
        })
    }
    
}

extension SlideMenuViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SlideMenuTableViewCell.cellIdentifier(), for: indexPath) as! SlideMenuTableViewCell
            cell.selectionStyle = .none
            cell.iconImageView.image = imagesArray[indexPath.row]
        cell.sectionNameLabel.text = sectionNamesArray[indexPath.row]()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToPage(page: viewControllersArray[indexPath.row])
    }
    
}

extension SlideMenuViewController {
    
    
    private func setUserType()  {
        
        guard viewModel.isValid() else {self.showErrorMessage(messageType: .none, viewModel.errorMessage); return}
        let parameters = viewModel.getParameters()
        showLoader()
        parameters?.forEach({ (key,value) in
            print("key : \(key)\n")
            print("value : \(value)\n\n")
        })

        ParseManager.shared.multipartFormData(url: AppConstants.API.editProfile, parameters: parameters, success: { (result: User) in
            
            
            let user: User? = User(token: UserManager.shared.getCurrentUser()?.token, user: result.user)
        UserManager.shared.createSession(withUser: user!)
//            UserManager.setUserType(type: result.user!.type)

            
            self.navigationController?.pushViewController(MainPageViewController(), animated: true)
            self.tableView.reloadData()

        }) { (error) in
            self.showErrorMessage(messageType: .error, error)
            self.hideLoader()
            
        }
    }
}
