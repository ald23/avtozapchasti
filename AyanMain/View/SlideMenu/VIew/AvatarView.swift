//
//  AvatarView.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class AvatarView: UIView {
    var profileImage : UIImageView = {
        var image = UIImageView()
            image.clipsToBounds = true
            image.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            image.image = #imageLiteral(resourceName: "language")
            image.contentMode = .center
            image.layer.cornerRadius = 44
            image.contentMode = .scaleAspectFill
            image.translatesAutoresizingMaskIntoConstraints = false

        
        return image
    }()
    var nameLabel = Label(title: "Агадиль Ушкемпиров".localized(), type: .Medium, textSize: 18)
    var roleLabel = Label(title: "Покупатель".localized(), type: .Regular)
    var nextIconImageView : UIImageView = {
        var image = UIImageView()
            image.image = #imageLiteral(resourceName: "Vector-1")
        
        return image
    }()
    var action : (()->())?
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        gestureSetup()
    }
    fileprivate func gestureSetup() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureTarget))
        addGestureRecognizer(gesture)
    }
    
    @objc func gestureTarget(){
        action?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        addSubview(profileImage)
        profileImage.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.height.equalTo(88)
        }
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(profileImage.snp.right).offset(16)
            make.top.equalTo(15)
        }
        addSubview(roleLabel)
        roleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(nameLabel)
        }
        addSubview(nextIconImageView)
        nextIconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(5)
            make.height.equalTo(10)
            make.left.equalTo(nameLabel.snp.right).offset(16)
            make.right.equalTo(0)
        }
        
        
        
    }
    
}
