//
//  DetailCollectionViewCell.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/17/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    var backView : UIView = {
        var backView = UIView()
            backView.layer.cornerRadius = 15
            backView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    
        return backView
    }()
    var cellNameLabel = Label(title: "Запчасти по ходовке", type: .Medium, textSize: 10)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setupView() {
        
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        backView.addSubview(cellNameLabel)
        cellNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
    }
    
}
