//
//  ProfileEditView.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/13/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class ProfileMainView: UIView {

    var profileImageView : UIImageView = {
        var image = UIImageView()
            image.image = #imageLiteral(resourceName: "Vector-6")
            image.contentMode = .center
            image.layer.cornerRadius = 60
            image.clipsToBounds = true
            image.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            image.contentMode = .scaleAspectFill
            image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    var nameLabel = Label(title: "Агадиль Ушкемпиров".localized(), type: .Medium, textSize: 15, aligment: .center)
    var locationIcon : UIImageView = {
        var image = UIImageView()
            image.image = #imageLiteral(resourceName: "carbon_location")
            image.clipsToBounds = true
        
        return image
    }()
    var locationLabel = Label(title: "Тараз, Казахстан", type: .Medium, textSize: 13, aligment: .center, changedDefaultColor: #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(120)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
        }
        addSubview(locationLabel)
        locationLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            
        }
        addSubview(locationIcon)
        locationIcon.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.right.equalTo(locationLabel.snp.left).offset(-4)
            make.width.height.equalTo(16)
            make.bottom.equalTo(0)
        }
    }
}
