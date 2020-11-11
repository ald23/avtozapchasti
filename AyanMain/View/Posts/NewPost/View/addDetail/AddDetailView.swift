//
//  AddDetailView.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/17/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class AddDetailView: UIView {
    let collectionView: DynamicHeightCollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
        let collection = DynamicHeightCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            collection.backgroundColor = .clear
            collection.isScrollEnabled = true
    
        return collection
    }()
    
    
    var nextIconImageView : UIImageView = {
        var image = UIImageView()
            image.image = #imageLiteral(resourceName: "Vector-1")
            image.contentMode = .scaleAspectFit
        
        return image
    }()
    var detailsArray = [AddingServicesCatListModel]()
    
    var gestureTargetAction : (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupCollectionView()
        setupAction()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupAction(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureTarget))
        addGestureRecognizer(gesture)
    }
    @objc func gestureTarget(){
        gestureTargetAction?()
    }
    func setupView(){
        backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        clipsToBounds = true
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
            make.left.equalTo(11)
            make.right.equalTo(-40)
        }
        addSubview(nextIconImageView)
        nextIconImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(14)
            make.right.equalTo(-26)
            make.centerY.equalToSuperview()
        }
    }
    func setupCollectionView(){
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.cellIdentifier())
    }

}
extension AddDetailView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.cellIdentifier(), for: indexPath) as! DetailCollectionViewCell
        cell.cellNameLabel.text = detailsArray[indexPath.row].name
        
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = "\(detailsArray[indexPath.row])"
        let cellWidth = text.size(withAttributes:[.font: UIFont.getMontserratMedium(of: 10)]).width + 30
        return CGSize(width: cellWidth, height: 32)

     }
    func collectionView(_ collectionView: UICollectionView, layout
                 collectionViewLayout: UICollectionViewLayout,
                                 minimumLineSpacingForSectionAt section: Int) -> CGFloat {

      return 8
     }
    
}
