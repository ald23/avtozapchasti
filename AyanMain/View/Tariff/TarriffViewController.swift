//
//  TarriffViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class TarriffViewController: LoaderBaseViewController {
    
    private var viewModel = EditViewModel()

    var navBar : NavigationBar = {
        var navBar = NavigationBar(title: "Пробная подписка".localized(), rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "Group-1"))
            navBar.backgroundColor = .clear
            navBar.titleLabel.textColor = .white
        
        return navBar
    }()
    var switcher = SwitcherView(firstTitle: "Клиент".localized(), secondTitle: "Продавец".localized(), isWhite: true)
    
    var backgroundImage : UIImageView = {
        var image = UIImageView()
        image.image = #imageLiteral(resourceName: "Тариф")
        return image
    }()
    
    var infoLabel = Label(title: "Ваше опубликованное обьявление будет активным в течение 5 дней".localized(), type: .Medium, textSize: 14, aligment: .center, changedDefaultColor: .white)
    
    var monthFreeLabel = Label(title: "Вам будут доступны первые 2 месяца бесплатно".localized(), type: .Bold, textSize: 21, aligment: .center, changedDefaultColor: .white)
    var priceLabel = Label(title: "Далее 500тг за каждое новое обьявление".localized(), type: .Regular, textSize: 13, aligment: .center, changedDefaultColor: .white)
    var balanceButton =  MainButton(title: "Пополнить баланс".localized())
    var privacyLabel = PrivacyLabel(selectedColor: #colorLiteral(red: 0.1450980392, green: 0.4509803922, blue: 0.8352941176, alpha: 1), deselectedColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), aligment: .center)

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        
        
    }
    
    private func setupAction(){

        let tap = UITapGestureRecognizer(target: self, action: #selector(privacyLabelTapButton))
        privacyLabel.isUserInteractionEnabled = true
        privacyLabel.addGestureRecognizer(tap)

        navBar.leftButtonAction = {
             self.sideMenuController?.showLeftViewAnimated()
        }
        
        switcher.firstAction = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.setType("USER")
            self.infoLabel.text = "Ваше опубликованное обьявление будет активным в течение 5 дней"
            self.priceLabel.text = "Далее 500тг за каждое новое обьявление"
            self.tapType()

            UserManager.shared.setUserSeller(isExecute: false)
            self.sideMenuController?.hideLeftView(animated: true, completionHandler: {
                AppCenter.shared.start()
            })
        }
        
        switcher.secondAction = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.setType("SELLER")
            self.infoLabel.text = "У вас есть возможность получать уведомления о новых поступивших заказах. Договаривайтесь с клиентами и выполняйте заказы"
            self.priceLabel.text = "Далее 1 000KZT за каждый день эксплуатации продукта"
            self.tapType()
            UserManager.shared.setUserSeller(isExecute: true)
            
            self.sideMenuController?.hideLeftView(animated: true, completionHandler: {
                AppCenter.shared.start()
            })

        }
        
        balanceButton.action = { [weak self] in
            guard let `self` = self else { return }
            self.tapDeposit()
        }


    }
    func setupView(){
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1.5 * AppConstants.totalNavBarHeight)
        }
        addSubview(switcher)
        switcher.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(24)
            make.height.equalTo(40)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(switcher.snp.bottom).offset(AppConstants.screenHeight / 7)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        addSubview(monthFreeLabel)
        monthFreeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(AppConstants.screenHeight / 7)
            make.left.right.equalTo(infoLabel)
        }
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(monthFreeLabel.snp.bottom).offset(8)
            make.left.right.equalTo(monthFreeLabel)
        }
        addSubview(privacyLabel)
        privacyLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-45)
            make.left.right.equalTo(infoLabel)
        }
        addSubview(balanceButton)
        balanceButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(infoLabel)
            make.height.equalTo(52)
            make.bottom.equalTo(privacyLabel.snp.top).offset(-20)
        }
    }
    
    @objc func privacyLabelTapButton(){
        navigationController?.pushViewController(PolicyViewController(), animated: true)

    }

    private func tapType() -> Void {
        setUserType()

    }
    
    private func tapDeposit() -> Void {
        navigationController?.pushViewController(PolicyViewController(), animated: true)

    }



}

extension TarriffViewController {


    private func setUserType()  {

        guard viewModel.isValid() else {self.showErrorMessage(messageType: .none, viewModel.errorMessage); return}
        let parameters = viewModel.getParameters()
        showLoader()

        ParseManager.shared.multipartFormData(url: AppConstants.API.editProfile, parameters: parameters, success: { (result: User) in
//
//
//            let user: User? = User(token: UserManager.shared.getCurrentUser()?.token, user: result.user)
//        UserManager.shared.createSession(withUser: user!)
//            UserManager.setUserType(type: result.user!.type)


        }) { (error) in
            self.showErrorMessage(messageType: .error, error)
            self.hideLoader()

        }
    }
}
