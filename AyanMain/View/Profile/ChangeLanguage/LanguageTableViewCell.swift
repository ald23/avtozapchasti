//
//  LanguageTableViewCell.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/14/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    var languageLabel = Label(title: "Русский", type: .Medium, textSize: 14)
    
    var bottomLineView : UIView = {
        var view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            selectionImageView.isHidden = !isselected
        }
    }
    
    var isselected = false {
        didSet {
            selectionImageView.isHidden = !isselected
        }
    }
    
    var selectionImageView : UIImageView = {
        var image = UIImageView()
            image.image = #imageLiteral(resourceName: "Vector 8")
            image.contentMode = .center
        
        return image
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(data : AddingServicesCatListModel){
        languageLabel.text = data.name
    }

    
    func setupView(){
        addSubview(languageLabel)
        languageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.bottom.equalTo(-11)
            make.left.equalToSuperview()
        }
        addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-1)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        addSubview(selectionImageView)
        selectionImageView.snp.makeConstraints { (make) in
            make.top.equalTo(languageLabel)
            make.width.equalTo(24)
            make.height.equalTo(11)
            make.right.equalTo(-18)
        }
    }
}
