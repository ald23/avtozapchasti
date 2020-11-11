//
//  SlideMenuTableViewCell.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class SlideMenuTableViewCell: UITableViewCell {
    var iconImageView : UIImageView = {
        var image = UIImageView()
            image.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
            image.image = #imageLiteral(resourceName: "house")
            image.layer.cornerRadius = 20
            image.contentMode = .center
        
        return image
    }()
    var sectionNameLabel = Label(title: "Главная".localized(), type: .Medium, textSize: 15)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.top.equalTo(8)
            make.left.equalTo(16)
            make.bottom.equalTo(-9)
        }
        addSubview(sectionNameLabel)
        sectionNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(12)
        }
        
    }
    
}
