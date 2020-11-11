//
//  ProfileView.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    var profileImage : UIImageView = {
        let image = UIImageView()
            image.image = #imageLiteral(resourceName: "Vector-3")
            image.clipsToBounds = true
            image.layer.cornerRadius = 24
            image.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false

        
        return image
    }()
    var nameLabel = Label(title: "Бекарыс Ибрагимов", type: .Medium, textSize: 15)
    var infoLabel = Label(title: "Откликнулся на ваше обьявление".localized(), type: .Regular, textSize: 12)
    var starView = StarView(size: .medium)
    
    var phoneButton = CallButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(profileImage)
        profileImage.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.height.equalTo(48)
        }
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(6)
            make.left.equalTo(profileImage.snp.right).offset(8)
        }
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(nameLabel)
        }
        addSubview(starView)
        starView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(8)
            make.top.equalTo(nameLabel).offset(2)
        }
        addSubview(phoneButton)
        phoneButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(4)
            make.width.height.equalTo(32)
        }
        
        
    }
    
}
