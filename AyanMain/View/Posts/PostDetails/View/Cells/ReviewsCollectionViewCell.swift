//
//  ReviewsCollectionViewCell.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/13/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit
import Cosmos
class ReviewsCollectionViewCell: UICollectionViewCell {
    var backView = BackView()
    var nameLabel = Label(title: "Жанбатыр", type: .Medium, textSize: 14)
    var starsView = CosmosView()
    var commentLabel = Label(title: "Ребята красавцы! Подобрали нужную запчасть оперативно и профессионально. Время доставки тоже не подвела. 5 из 5 однозначно!", type: .Regular, textSize: 12)
    var dateLabel = Label(title: "12 октября 2020", type: .Medium, textSize: 10, changedDefaultColor: #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1))
    
    var showAllReviews = {(id : Int) -> () in}

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupCosmos()
    }
    
    func setupData(data : ReviewDataParametersModel){
        nameLabel.text    = String(describing: data.seller_name!)
        commentLabel.text = String(describing: data.text!)
    }
    

    func setupCosmos(){
        starsView.rating = 2.3
        starsView.settings.updateOnTouch = false
        starsView.settings.starSize = 10
        starsView.settings.filledColor = #colorLiteral(red: 0.9490196078, green: 0.7882352941, blue: 0.2980392157, alpha: 1)
        starsView.settings.emptyBorderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        starsView.settings.starMargin = 5
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupView() {
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        backView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(12)
        }
        backView.addSubview(starsView)
        starsView.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.right.equalTo(-12)
        }
        addSubview(commentLabel)
        commentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.right.equalTo(-12)
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
        }
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(commentLabel.snp.bottom).offset(8)
            make.right.equalTo(-12)
            make.bottom.equalTo(-14)
        }
    }
}
