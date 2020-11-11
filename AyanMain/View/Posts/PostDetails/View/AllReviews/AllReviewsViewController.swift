//
//  AllReviewsViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/18/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class AllReviewsViewController: LoaderBaseViewController {
    

    var user_id = 0
    var navBar = NavigationBar(title: "Отзывы".localized(), rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "feather_chevron-left"))
    
    var reviews : [ReviewDataParametersModel] = [] {
        didSet {
        collectionView.reloadData()
        }
    }

    let collectionView: DynamicHeightCollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
        let collection = DynamicHeightCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            collection.backgroundColor = .clear
            collection.isScrollEnabled = true
    
        return collection
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getReviews()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupAction()
    }
    func setupAction(){
        navBar.leftButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func setupView(){
        view.backgroundColor = .white
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(AppConstants.totalNavBarHeight * 1.5)
        }
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navBar.snp.bottom).offset(28)
            
        }
        
    }
    
    func setupCollectionView(){
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ReviewsCollectionViewCell.self, forCellWithReuseIdentifier: ReviewsCollectionViewCell.cellIdentifier())
    }
 

}
extension AllReviewsViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
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

extension AllReviewsViewController {
    
    private func getReviews() {

      
        
        var parameters = Parameters()

        parameters["user_id"] = user_id

        
        ParseManager.shared.multipartFormData(url: AppConstants.API.getReviewsListById, parameters: parameters, success: { (result: userReviewModel) in
           
            
            self.reviews = result.data


        }) { (error) in
           
        }

    }

}
//    private func getReviews() {
//
//        showLoader()
//
//        ParseManager.shared.getRequest(url: AppConstants.API.getReviewsList, success: { (result: userReviewModel) in
//            self.hideLoader()
//
//            self.reviews = result.data
//
//            self.collectionView.reloadData()
//
//        }) { (error) in
//            self.showErrorMessage(messageType: .error, error)
//        }
//
//    }
//
