//
//  HeaderView.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/11/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    var topLabel = Label(title: "Вход",type: .Bold)
    var bottomLabel = Label(title: "Введите ваши данные", type: .Regular)
   
    init(topLabelText : String, subLabelText :String) {
        super.init(frame: .zero)
        self.topLabel.text = topLabelText
        self.bottomLabel.text = subLabelText
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(8)
            make.bottom.right.left.equalToSuperview()
            
        }
    }

}
