//
//  OrderAcceptedViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/18/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class OrderAcceptedViewController: LoaderBaseViewController {
    
    
    var id = 0
    var user_id = 0

    var orders = [PostData]()

    var navBar =  NavigationBar(title: "Заказ принят".localized(), rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "feather_chevron-left"))
    var avatarView = ProfileView()
//    var detailTableView = UITableView()
    var brandNameSection    = SectionAndValueView(title: "Марка",  value: "Lexus")
    var brandModelSection   = SectionAndValueView(title: "Модель", value: "RX 300")
    var yearSection         = SectionAndValueView(title: "Год", value: "2002")
    var serviceSection      = SectionAndValueView(title: "Деталь", value: "Двигатель")
    var serviceCatSection   = SectionAndValueView(title: "Подкатегория детали", value: "Под деталь")

    var commentView = CommentView()
    var reviewButton = MainButton(title: "Оставить отзыв".localized())
    var cancelButton = MainButton(title: "Отменить заказ".localized(), type: .gray)
    let nextPresentingVC = ReviewViewController()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getMyPostDetail()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        setupTableView()
        setupAction()
    }
    func setupAction(){
        nextPresentingVC.modalPresentationStyle = .overCurrentContext
        reviewButton.action = {
            self.nextPresentingVC.id = self.id
            self.nextPresentingVC.user_id = self.user_id
            self.present(self.nextPresentingVC,animated: true)

        }
        navBar.leftButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        cancelButton.action = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupData(data : PostData){
//        priceSection.sectionValue.text = String(describing: data.price!)
        avatarView.nameLabel.text = data.user!  
        avatarView.infoLabel.text = data.city!
        if let url = data.user_avatar?.url{
            avatarView.profileImage.kf.setImage(with: url)
        }

        brandNameSection.sectionValue.text          = data.brand!
        brandModelSection.sectionValue.text         = data.brand_model!
        yearSection.sectionValue.text               = String(describing: data.year!)
        if data.services!.count > 0 {
            serviceSection.sectionValue.text        = String(describing: data.services![0].service)
            serviceCatSection.sectionValue.text     = String(describing: data.services![0].service_cat)
        }
        commentView.commentLabel.text               = data.description
        user_id                                     = data.user_id!
    }


    func setupView(){
        view.backgroundColor = .white
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.right.left.top.equalToSuperview()
            make.height.equalTo(AppConstants.totalNavBarHeight * 1.5)
        }
        contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints { (make) in
            make.top.equalTo(AppConstants.totalNavBarHeight * 1.5 + 40)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        contentView.addSubview(brandNameSection)
        brandNameSection.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(avatarView.snp.bottom).offset(20)
        }
        contentView.addSubview(brandModelSection)
        brandModelSection.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(brandNameSection.snp.bottom).offset(12)
        }
        contentView.addSubview(yearSection)
        yearSection.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(brandModelSection.snp.bottom).offset(12)
        }
        contentView.addSubview(serviceSection)
        serviceSection.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(yearSection.snp.bottom).offset(12)
        }
        contentView.addSubview(serviceCatSection)
        serviceCatSection.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(serviceSection.snp.bottom).offset(12)
        }

//        contentView.addSubview(detailTableView)
//        detailTableView.snp.makeConstraints { (make) in
//            make.top.equalTo(avatarView.snp.bottom).offset(20)
//            make.height.equalTo(sectionNames.count * 30) //cell height = 30
//            make.left.right.equalTo(avatarView)
//        }
        contentView.addSubview(commentView)
        commentView.snp.makeConstraints { (make) in
            make.top.equalTo(serviceCatSection.snp.bottom).offset(12)
            make.left.right.equalTo(serviceCatSection)
            
        }
        contentView.addSubview(reviewButton)
        reviewButton.snp.makeConstraints { (make) in
            make.top.equalTo(commentView.snp.bottom).offset(150)
            make.left.right.equalTo(serviceCatSection)
            make.height.equalTo(52)
        }
        contentView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(reviewButton.snp.bottom)
            make.left.right.equalTo(serviceCatSection)
            make.height.equalTo(52)
            make.bottom.equalTo(-5)
        }
        
        
    }
//    func setupTableView() {
//        detailTableView.separatorStyle = .none
//        detailTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.cellIdentifier())
//        detailTableView.separatorStyle = .none
//        detailTableView.isScrollEnabled = false
//
//    }

}

extension OrderAcceptedViewController {
    private func getMyPostDetail() {

        var parameters = Parameters()
        parameters["order_id"] = id
        showLoader()

        ParseManager.shared.getRequest(url: AppConstants.API.getByOrderID, parameters: parameters, success: { (result: [PostData]) in
            self.setupData(data: result[0])
            self.hideLoader()

            
        }) { (error) in
            self.showErrorMessage(messageType: .error, error)
        }

    }

    

}
