//
//  CommentView.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class CommentView: UIView {
    var commentTopLabel = Label(title: "Комментарий:", type: .Regular,textSize: 12)
    var commentLabel = Label(title: "Лучший из когда-либо созданных, Lexus RX доставляет еще больше удовольствия от вождения и предлагает небывалый уровень роскоши. Он также оснащен комплексом систем активной безопасности нового поколения Lexus Safety System+.", type: .Medium, textSize: 12)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        addSubview(commentTopLabel)
        commentTopLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
        }
        addSubview(commentLabel)
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(commentTopLabel.snp.bottom).offset(4)
            make.left.bottom.right.equalToSuperview()
            
        }
    }
}
