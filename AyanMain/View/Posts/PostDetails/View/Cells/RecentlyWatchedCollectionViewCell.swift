//
//  RecentlyWatchedCollectionViewCell.swift
//  Talim-trend MAIN
//
//  Created by Bakdaulet Myrzakerov on 7/15/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation
import UIKit

class RecentlyWatchedCollectionViewCell: UICollectionViewCell {
    var backView = BackView()
    var avatarView = CallAvatarView()
    
    var showAllCells = {(id : Int) -> () in}

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(data : CallsDataParametersModel){
        avatarView.nameLabel.text = String(describing: data.from_name!)
}

    func setupView() {
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        addSubview(avatarView)
        avatarView.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(12)
            make.bottom.equalTo(-16)
        }
    }
    
}
