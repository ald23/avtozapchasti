//
//  AvatarView.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/13/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//
//
import UIKit

class CallAvatarView: UIView {
    var avatarImage : UIImageView = {
        var image = UIImageView()
            image.image = #imageLiteral(resourceName: "Vector-3")
            image.layer.cornerRadius = 16
            image.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            image.clipsToBounds = true
        
        return image
    }()
    var starView = StarView(size: .small)
    
    var nameLabel = Label(title: "Жанбатыр", type: .Medium)
    var timeLabel = Label(title: "12ч. назад", type: .Regular, textSize: 10)
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        addSubview(avatarImage)
        avatarImage.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.height.width.equalTo(32)
        }
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImage)
            make.left.equalTo(avatarImage.snp.right).offset(8)
        }
        addSubview(starView)
        starView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(4)
            make.top.equalTo(nameLabel).offset(4)
        }
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.bottom.equalTo(0)
        }
    }
}
