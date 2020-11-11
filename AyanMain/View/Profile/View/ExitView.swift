//
//  ExitButton.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/13/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class ExitView: UIView {
    var iconImageView : UIImageView = {
        var image = UIImageView()
            image.layer.cornerRadius = 4
            image.clipsToBounds = true
            image.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            image.contentMode = .center
            image.image = #imageLiteral(resourceName: "Group-3")
        
        return image
    }()
    var nextIconImageView : UIImageView = {
        var image = UIImageView()
            image.image = #imageLiteral(resourceName: "Vector-7")
        
        return image
    }()
    var sectionNameLabel = Label(title: "Изменить данные".localized(), type: .Medium, textSize: 14, changedDefaultColor: #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 4
        self.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(12)
            make.bottom.equalTo(-14)
            make.width.height.equalTo(32)
        }
        addSubview(sectionNameLabel)
        sectionNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(8)
            make.top.equalTo(14)
            
        }
        addSubview(nextIconImageView)
        nextIconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(23)
            make.right.equalTo(-20)
            make.width.equalTo(5)
            make.height.equalTo(10)
        }
        
    }
    
}
