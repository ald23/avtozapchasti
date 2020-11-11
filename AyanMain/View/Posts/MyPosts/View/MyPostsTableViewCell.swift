//
//  MyPostsTableViewCell.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class MyPostsTableViewCell: UITableViewCell {

    var backView = BackView()
    var profileImage : UIImageView = {
        var image = UIImageView()
            image.image = #imageLiteral(resourceName: "Vector-2")
            image.layer.cornerRadius = 20
            image.clipsToBounds = true
            image.contentMode = .center
        
        return image
    }()
    
    var deleteMyPost = {(id : Int) -> () in}
    var currentID = Int()
    
    var carNameLabel = Label(title: "Lexus RX300", type: .Bold, textSize: 15)
    var deleteButton : UIButton = {
        var button = UIButton()
            button.layer.cornerRadius = 18
            button.layer.borderWidth = 1
            button.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            button.setImage(#imageLiteral(resourceName: "Group f"), for: .normal)

        return button
    }()
//
    
    var releaseYearView = SectionAndValueView(title: "Год".localized(), value: "2002")
    var componentView = SectionAndValueView(title: "Деталь".localized(), value: "Двигатель")
    var deadlineView = SectionAndValueView(title: "Срок".localized(), value: "1 неделя")
    var priceView = SectionAndValueView(title: "Цена".localized(), value: "20 000тг")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style : style, reuseIdentifier: reuseIdentifier)
        setupView()
        deleteButton.addTarget(self, action: #selector(tapDelete), for: .touchUpInside)
        
        if UserManager.shared.isSeller(){
            deleteButton.isHidden = true

        }else{
            deleteButton.isHidden = false
        }

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupData(data : PostData){
        currentID = data.id!
        carNameLabel.text                        = String(describing: data.brand_model!)
        releaseYearView.sectionValue.text        = String(describing: data.year!)
        if data.services!.count > 0 {
            componentView.sectionValue.text      = String(describing: data.services![0].service)
            componentView.sectionName.text       = String(describing: data.services![0].service_cat)
        }
        deadlineView.sectionValue.text           = data.time!
        priceView.sectionValue.text              = String(describing: data.price!)
        
    }


    
    @objc func tapDelete() {
            deleteMyPost(currentID)
    }


    
    func setupView(){
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.right.equalToSuperview()
        }
        backView.addSubview(profileImage)
        profileImage.snp.makeConstraints { (make) in
            make.top.left.equalTo(12)
            make.height.width.equalTo(40)
        }
        backView.addSubview(carNameLabel)
        carNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileImage)
            make.left.equalTo(profileImage.snp.right).offset(12)
        }
        backView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.centerY.equalTo(profileImage)
            make.width.height.equalTo(36)
        }
        backView.addSubview(releaseYearView)
        releaseYearView.snp.makeConstraints { (make) in
            make.top.equalTo(profileImage.snp.bottom).offset(12)
            make.left.equalTo(12)
            make.right.equalTo(-12)
        }
        backView.addSubview(componentView)
        componentView.snp.makeConstraints { (make) in
            make.top.equalTo(releaseYearView.snp.bottom).offset(8)
            make.left.right.equalTo(releaseYearView)
        }
        backView.addSubview(deadlineView)
        deadlineView.snp.makeConstraints { (make) in
            make.top.equalTo(componentView.snp.bottom).offset(8)
            make.left.right.equalTo(releaseYearView)
        }
        backView.addSubview(priceView)
        priceView.snp.makeConstraints { (make) in
            make.top.equalTo(deadlineView.snp.bottom).offset(8)
            make.left.right.equalTo(releaseYearView)
            make.bottom.equalTo(-5)
        }
        
    }
    

    
}
