//
//  ProfileTableViewCell.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/13/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    var iconImageView : UIImageView = {
        var image = UIImageView()
            image.layer.cornerRadius = 4
            image.clipsToBounds = true
            image.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            image.contentMode = .center
        return image
    }()
    
    var switcher = CustomSwitch()
    
    var sectionNameLabel = Label(title: "Изменить данные".localized(), type: .Medium, textSize: 14, changedDefaultColor: #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1))
    var borderView : UIView = {
        var view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        
        return view
    }()
    var nextIconImageView : UIImageView = {
        var image = UIImageView()
        image.image = #imageLiteral(resourceName: "Vector-7")
        
        return image
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        self.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        self.clipsToBounds = true
        
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(12)
            make.bottom.equalTo(-14)
            make.width.height.equalTo(32)
        }
        addSubview(sectionNameLabel)
        sectionNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(8)
            make.top.equalTo(19)
            
        }
        addSubview(borderView)
        borderView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.equalTo(52)
            make.right.equalToSuperview()
            make.bottom.equalTo(-1)
        }
        addSubview(nextIconImageView)
        nextIconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(23)
            make.right.equalTo(-20)
            make.width.equalTo(5)
            make.height.equalTo(10)
        }
        addSubview(switcher)
        switcher.snp.makeConstraints { (make) in
            make.width.equalTo(44)
            make.height.equalTo(24)
            make.right.equalTo(-12)
            make.top.equalTo(14)
        }
        
    }
    func setupCell(index: Int){
        nextIconImageView.isHidden = index == 3 || index == 4
        switcher.isHidden = !nextIconImageView.isHidden
    }
    
    
}
