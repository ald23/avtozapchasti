//
//  SectionAndValueView.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class SectionAndValueView: UIView {
    var sectionName = Label(title: "Год".localized(), type: .Regular)
    var sectionValue = Label(title: "2002", type: .Medium)
    
    init(title: String, value:String) {
        super.init(frame: .zero)
        setupViews()
        self.sectionName.text = title
        self.sectionValue.text = value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(sectionName)
        sectionName.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
        }
        addSubview(sectionValue)
        sectionValue.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
        }
    }
    
}
