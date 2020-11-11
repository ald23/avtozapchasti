//
//  RecentlyCalledTableViewCell.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/18/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class RecentlyCalledTableViewCell: UITableViewCell {
    var backView = BackView()
    var profileView = ProfileView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setupData(data : CallsDataParametersModel){
        profileView.nameLabel.text = String(describing: data.from_name!)
    }

    func setupView(){
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.right.equalToSuperview()
        }
        backView.addSubview(profileView)
        profileView.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.bottom.equalTo(-17)
            make.left.equalTo(12)
            make.right.equalTo(-12)
        }

        
    }

}
