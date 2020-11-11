//
//  GroupTableViewCell.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/17/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit



class GroupTableViewCell: UITableViewCell {
    var backView = BackView()
    var iconImageView : UIImageView = {
        var image = UIImageView()
            image.image = #imageLiteral(resourceName: "Group 88")
            image.layer.cornerRadius = 28
            image.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            image.contentMode = .center
            image.clipsToBounds = true
            image.contentMode = .scaleAspectFill
            image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()
    var sectionNameLabel = Label(title: "СТО", type: .Bold, textSize: 14, changedDefaultColor: #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.3019607843, alpha: 1))
    var nextIconImageView : UIImageView = {
        var image = UIImageView()
            image.image = #imageLiteral(resourceName: "Vector-1")
            image.contentMode = .center

        return image
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setupData(data : AddingServicesListModel){
        sectionNameLabel.text = data.name
//            iconImageView.kf.setImage(with: data.icon)
        iconImageView.kf.setImage(with: data.icon?.serverUrlString.url)
    }

    func setupView(){
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.left.right.equalToSuperview()
        }
        backView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.bottom.equalTo(-4)
            make.left.equalTo(12)
            make.width.height.equalTo(56)
        }
        backView.addSubview(sectionNameLabel)
        sectionNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        backView.addSubview(nextIconImageView)
        nextIconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(14)
            make.right.equalTo(-20)
        }

    }

}
