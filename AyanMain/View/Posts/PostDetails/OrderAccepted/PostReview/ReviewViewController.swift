//
//  ReviewViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/18/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit
import Cosmos
class ReviewViewController: LoaderBaseViewController {
    
    var id = 0
    var user_id = 0
    
    private var viewModel = CreateReviewViewModel()

    var viewOnTopForDismissing = UIVisualEffectView()
    
    var mainView : UIView = {
        var view = UIView()
            view.backgroundColor = .white
            
        return view
    }()
    var starsView = CosmosView()
    var reviewLabel = Label(title: "Оцените заказ".localized(), type: .Bold,textSize: 27)
    var infoLabel = Label(title: "Оцените качество работы продавца. Оставляя свой отзыв, Вы улучшаете качество сервиса".localized(), type: .Regular,textSize: 12)
    var profileView = ProfileMainView()
    var commentInputView = InputView(inputType: .comment, placeholder: "     \nКакие впечатления от выполненного заказа?".localized(), topLabelText: "")
    var sendButton = MainButton(title: "Отправить".localized())
    var closeButton = MainButton(title: "Закрыть".localized(), type: .gray)
    
    
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        mainView.roundCorners(corners: [.topRight, .topLeft], radius: 20)
        let blur = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
        viewOnTopForDismissing.effect = blur
        viewOnTopForDismissing.alpha = 0.3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getMyPostDetail()

    }

    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCosmos()
        setupAction()
    }
    
    func setupData(data : PostData){
        profileView.nameLabel.text = data.user
        profileView.locationLabel.text = data.city
        if let url = data.user_avatar?.url{
            profileView.profileImageView.kf.setImage(with: url)
        }

    }

    

    
    func setupAction(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        viewOnTopForDismissing.addGestureRecognizer(tapGesture)
        
        sendButton.action = { [weak self] in
            guard let `self` = self else { return }
            self.tapReview()
            self.dismissAction()

        }
        
        closeButton.action = { [weak self] in
            guard let `self` = self else { return }
            self.dismissAction()

        }

    }
    func setupCosmos(){
        starsView.rating = 3
        starsView.settings.updateOnTouch = true
        starsView.settings.starSize = 23
        starsView.settings.filledColor = #colorLiteral(red: 0.9490196078, green: 0.7882352941, blue: 0.2980392157, alpha: 1)
        starsView.settings.emptyBorderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        starsView.settings.filledImage = #imageLiteral(resourceName: "Vector-5")
        starsView.settings.emptyImage = #imageLiteral(resourceName: "Vector-9")
        starsView.settings.starMargin = 5
    }
    

    func setupView(){
        addSubview(viewOnTopForDismissing)
        viewOnTopForDismissing.snp.makeConstraints { (make) in
            make.top.right.left.equalToSuperview()
            make.bottom.equalTo(-544)
        }
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.bottom.right.left.equalToSuperview()
            make.height.equalTo(564)
            
        }
        mainView.addSubview(reviewLabel)
        reviewLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
        }
        mainView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(reviewLabel.snp.bottom).offset(4)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        mainView.addSubview(profileView)
        profileView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
        }
        mainView.addSubview(starsView)
        starsView.snp.makeConstraints { (make) in
            make.top.equalTo(profileView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        mainView.addSubview(commentInputView)
        commentInputView.snp.makeConstraints { (make) in
            make.top.equalTo(starsView.snp.bottom).offset(16)
            make.left.right.equalTo(infoLabel)
            make.height.equalTo(120)
        }
        mainView.addSubview(sendButton)
        sendButton.snp.makeConstraints { (make) in
            make.top.equalTo(commentInputView.snp.bottom).offset(32)
            make.left.right.equalTo(infoLabel)
            make.height.equalTo(52)
        }
        mainView.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(sendButton.snp.bottom)
            make.left.right.height.equalTo(sendButton)
        }
    }
    
    private func tapReview() -> Void {
        review()


    }


}


extension ReviewViewController {
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
    
    private func review() -> Void {

        viewModel.setDescription(commentInputView.commentTextView.text!)
        
        guard viewModel.isValid() else {self.showErrorMessage(messageType: .none, viewModel.errorMessage); return}
        var parameters = viewModel.getParameters()
        
        parameters!["user_id"] = user_id
        
        ParseManager.shared.multipartFormData(url: AppConstants.API.createReview, parameters: parameters, success: { (result: Review?) in
            
            self.navigationController?.pushViewController(MainPageViewController(), animated: true)
        }) { (error) in
            self.showErrorMessage(messageType: .error, error)

        }


    }
}

