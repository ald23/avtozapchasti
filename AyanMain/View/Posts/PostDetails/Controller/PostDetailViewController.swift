//
//  PostDetailViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class PostDetailViewController: LoaderBaseViewController {

    var id = 0
    var user_id = 0
    private var post: PostData?
    
    var navBar = NavigationBar(title: "Детали обьвления".localized(), leftButtonImage: #imageLiteral(resourceName: "feather_chevron-left"))
    var profileView         = ProfileView()
    var commentView         = CommentView()
    var brandNameSection    = SectionAndValueView(title: "Марка",  value: "Lexus")
    var brandModelSection   = SectionAndValueView(title: "Модель", value: "RX 300")
    var yearSection         = SectionAndValueView(title: "Год", value: "2002")
    var serviceSection      = SectionAndValueView(title: "Деталь", value: "Двигатель")
    var serviceCatSection   = SectionAndValueView(title: "Подкатегория детали", value: "Под деталь")
    var timeSection         = SectionAndValueView(title: "Срок", value: "10-11 дней")
    var priceSection        = SectionAndValueView(title: "Цена", value: "20 000 тг")
    var citySection         = SectionAndValueView(title: "Город", value: "Алматы")
    
    
    var recentlyCalledView = RecentlyCalledView()
    var reviewView = ReviewsView()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getMyPostDetail()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAction()
    
//        setupData()
//        if UserManager.shared.isSeller(){
//            postButton.isHidden = true
//            leaveMessageLabel.isHidden = true
//
//        }else{
//            navBar.rightButton.isHidden = true
//            searchButton.isHidden = true
//            leaveMessageLabelSearch.isHidden = true
//
//
//        }


        }
    
//    private func setupData(){
//        if let user = UserManager.shared.getCurrentUser() {
//            if let user = order.... {
//                profileView.phoneButton.isHidden = true
//            }
//        }
//
//
//    }
//

    func setupAction(){
        navBar.leftButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
        reviewView.watchAllAction = {[weak self] in
            let vc = AllReviewsViewController()
            vc.user_id = self!.post!.user_id!
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        profileView.phoneButton.callAction = {
            self.callUser()
            
            
            guard let number = URL(string: "tel://8" + self.post!.user_phone!) else { return }
            UIApplication.shared.open(number)
            
            self.showAlertWithAction(title: "Вы договорились с продавцом?".localized(), message: self.post?.user ?? "") {
                let vc = OrderAcceptedViewController()
                let reviewsVC = AllReviewsViewController()
                reviewsVC.user_id = self.user_id
                vc.id = self.id
//                vc.user_id = self.user_id
                self.callUser()

                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        recentlyCalledView.watchAllAction = {
            self.navigationController?.pushViewController(RecentlyCalledViewController(), animated: true)
        }

    }

    
    func setupData(data : PostData){
        
        self.post = data
        
        reviewView.user_id = post!.user_id!
            
        reviewView.getReviews()
        
        profileView.nameLabel.text = data.user
        profileView.infoLabel.text = "Клиент"
        
        if let url = data.user_avatar?.url{
            profileView.profileImage.kf.setImage(with: url)
        }

        brandNameSection.sectionValue.text          = data.brand!
        brandModelSection.sectionValue.text         = data.brand_model!
        yearSection.sectionValue.text               = String(describing: data.year!)
        if data.services!.count > 0 {
            serviceSection.sectionValue.text        = String(describing: data.services![0].service)
            serviceCatSection.sectionValue.text     = String(describing: data.services![0].service_cat)
        }
        timeSection.sectionValue.text               = data.time
        priceSection.sectionValue.text              = String(describing: data.price!)
        citySection.sectionValue.text               = data.city
        commentView.commentLabel.text               = data.description
        
     
        profileView.phoneButton.isHidden = UserManager.shared.getCurrentUser()?.user?.id == data.user_id
        recentlyCalledView.isHidden = UserManager.shared.getCurrentUser()?.user?.id != data.user_id


    }

    func setupViews(){
        self.view.backgroundColor = .white
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(AppConstants.totalNavBarHeight * 1.75)
        }
        contentView.addSubview(profileView)
        profileView.snp.makeConstraints { (make) in
            make.top.equalTo(AppConstants.totalNavBarHeight * 2.0)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        contentView.addSubview(brandNameSection)
        brandNameSection.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(profileView.snp.bottom).offset(20)
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
        contentView.addSubview(timeSection)
        timeSection.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(serviceCatSection.snp.bottom).offset(12)
        }
        contentView.addSubview(priceSection)
        priceSection.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(timeSection.snp.bottom).offset(12)
        }
        contentView.addSubview(citySection)
        citySection.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(priceSection.snp.bottom).offset(12)
        }

        contentView.addSubview(commentView)
        commentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(citySection)
            make.top.equalTo(citySection.snp.bottom).offset(12)

        }
        contentView.addSubview(recentlyCalledView)
        recentlyCalledView.snp.makeConstraints { (make) in
            make.top.equalTo(commentView.snp.bottom).offset(12)
            make.left.right.equalTo(citySection)
        }
        contentView.addSubview(reviewView)
        reviewView.snp.makeConstraints { (make) in
            make.top.equalTo(recentlyCalledView.snp.bottom).offset(20)
            make.left.right.equalTo(citySection)
            make.bottom.equalTo(-20)
        }
    }



}


extension PostDetailViewController {
    private func getMyPostDetail() {

        var parameters = Parameters()
        parameters["order_id"] = id
//        if (parameters["user_id"] == user_id) {
//            profileView.phoneButton.isHidden = true
//
//        }
        showLoader()

        ParseManager.shared.getRequest(url: AppConstants.API.getByOrderID, parameters: parameters, success: { (result: [PostData]) in
            self.setupData(data: result[0])
            self.hideLoader()

            
        }) { (error) in
            self.showErrorMessage(messageType: .error, error)
        }

    }
    
    private func callUser() {

            showLoader()

            var parameters = Parameters()

            parameters["to"] = post?.user_id
            
            ParseManager.shared.multipartFormData(url: AppConstants.API.callUser, parameters: parameters, success: { (result: callNotification) in
                self.hideLoader()


            }) { (error) in
                self.showErrorMessage(messageType: .error, error)
            }

    }
    

    
}
