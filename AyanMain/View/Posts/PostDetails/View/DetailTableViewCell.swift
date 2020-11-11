//
//  DetailTableViewCell.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 9/16/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation
import UIKit

class DetailTableViewCell: UITableViewCell {
    var detailView = SectionAndValueView(title: "Город".localized(), value: "Алматы")

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//    func setupData(data : PostData){
//        detailView.sectionName.text = String(describing: data.brand_model!)
//        detailView.sectionValue.text = String(describing: data.brand_model!)
//    }


    func setupView(){
        addSubview(detailView)
        detailView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
        }

    }

    
}
