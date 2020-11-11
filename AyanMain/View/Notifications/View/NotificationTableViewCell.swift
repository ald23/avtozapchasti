//
//  NotificationTableViewCell.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/17/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    var backView = BackView()
    var circleImageView : UIImageView = {
        var image = UIImageView()
            image.layer.cornerRadius = 20
            image.clipsToBounds = true
            image.contentMode = .center
            image.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        
        return image
    }()
    var infoLabel = Label(title: "Жанбатыр звонил Вам вчера. Свяжитесь с ним, пожалуйста!".localized(), type: .Regular, textSize: 14, changedDefaultColor: #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.3019607843, alpha: 1))
    var callButton = CallButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(data : CallsDataParametersModel){
        infoLabel.text = String(describing: data.from_name!)
        
    }

    func setupView(){
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.right.equalToSuperview()
        }
        backView.addSubview(circleImageView)
        circleImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.top.equalTo(16)
            make.left.equalTo(12)
            make.bottom.equalTo(-16)
        }
        backView.addSubview(callButton)
        callButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(32)
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
            make.right.equalTo(-12)
        }
        backView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(circleImageView.snp.right).offset(8)
            make.right.equalTo(callButton.snp.left).offset(-8)
            make.top.equalTo(19)
        }
            
    }
    
}
