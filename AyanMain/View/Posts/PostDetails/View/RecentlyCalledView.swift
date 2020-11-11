//
//  RecentlyCalledView.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class RecentlyCalledView: UIView {
    var recentlyCalledLabel = Label(title: "Вам звонили:".localized(), type: .Regular, textSize: 12)
    
    var calls = [CallsDataParametersModel]()

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
        getCalls()
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
        collectionView.register(RecentlyWatchedCollectionViewCell.self, forCellWithReuseIdentifier: RecentlyWatchedCollectionViewCell.cellIdentifier())
    }
    func setupView(){
        addSubview(recentlyCalledLabel)
        recentlyCalledLabel.snp.makeConstraints { (make) in
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
            make.top.equalTo(watchAllButton.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(64)
            make.bottom.equalTo(0)
        }
    }
}
extension RecentlyCalledView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        calls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyWatchedCollectionViewCell.cellIdentifier(), for: indexPath) as! RecentlyWatchedCollectionViewCell
        cell.setupData(data: calls[indexPath.row])

        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: 200, height: 64)
     }
    func collectionView(_ collectionView: UICollectionView, layout
                 collectionViewLayout: UICollectionViewLayout,
                                 minimumLineSpacingForSectionAt section: Int) -> CGFloat {

      return 15
        
     }
}


extension RecentlyCalledView {
    private func getCalls() {

      

        ParseManager.shared.getRequest(url: AppConstants.API.getCallUser, success: { (result: getCallNotification) in
           
        self.calls = result.data



        }) { (error) in
           
        }

    }
}
