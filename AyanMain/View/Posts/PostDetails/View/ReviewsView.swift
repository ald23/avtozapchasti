//
//  ReviewsView.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/13/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class ReviewsView: UIView {
    
    
    var user_id = 0
        
//    var post: PostData?
    
    var reviewsLabe = Label(title: "Отзывы:".localized(), type: .Regular, textSize: 12)
        
    var reviews : [ReviewDataParametersModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

        var watchAllButton : UIButton = {
            var button = UIButton()
            button.setTitle("Смотреть все".localized(), for: .normal)
                button.titleLabel?.font = .getMontserratRegular(of: 12)
                button.setTitleColor(#colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1), for: .normal)
            
            return button
        }()
        let collectionView: DynamicHeightCollectionView = {
            let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                
            let collection = DynamicHeightCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
                collection.backgroundColor = .clear
                collection.isScrollEnabled = true
        
            return collection
        }()
        var watchAllAction : (()->())?
        override init(frame: CGRect) {
            super.init(frame: .zero)
            setupCollectionView()
            setupView()
            setupAction()
           // getReviews()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        func setupAction(){
            watchAllButton.addTarget(self, action: #selector(watchAllTarget), for: .touchUpInside)
        }
        @objc func watchAllTarget(){
            watchAllAction?()
        }
        func setupCollectionView(){
            collectionView.backgroundColor = .clear
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(ReviewsCollectionViewCell.self, forCellWithReuseIdentifier: ReviewsCollectionViewCell.cellIdentifier())
        }
        func setupView(){
            addSubview(reviewsLabe)
            reviewsLabe.snp.makeConstraints { (make) in
                make.top.left.equalToSuperview()
            }
            addSubview(watchAllButton)
            watchAllButton.snp.makeConstraints { (make) in
                make.top.right.equalToSuperview()
                make.width.equalTo(85)
                make.height.equalTo(15)
            }
            addSubview(collectionView)
            collectionView.snp.makeConstraints { (make) in
                make.top.equalTo(watchAllButton.snp.bottom).offset(16)
                make.left.right.equalToSuperview()
                make.height.equalTo(120)
                make.bottom.equalTo(0)
            }
        }
    }

extension ReviewsView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviews.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsCollectionViewCell.cellIdentifier(), for: indexPath) as! ReviewsCollectionViewCell
        cell.setupData(data: reviews[indexPath.row])

        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: 340, height: 120)
     }
    func collectionView(_ collectionView: UICollectionView, layout
                 collectionViewLayout: UICollectionViewLayout,
                                 minimumLineSpacingForSectionAt section: Int) -> CGFloat {

      return 12
}
}


    
extension ReviewsView {
    func getReviews() {

      
        
        var parameters = Parameters()

        parameters["user_id"] = user_id

        
        ParseManager.shared.multipartFormData(url: AppConstants.API.getReviewsListById, parameters: parameters, success: { (result: userReviewModel) in
           
            
            self.reviews = result.data
            
            print("----------->" + "\(self.reviews.count)" + "  \(self.user_id)" )

        }) { (error) in
           
        }

    }

    

}
