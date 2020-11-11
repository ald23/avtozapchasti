//
//  StarView.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/13/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit
enum StarSize {
    case medium
    case small
}
class StarView: UIView {
    var starImageView : UIImageView = {
        var image = UIImageView()
            image.clipsToBounds = true
            image.image = #imageLiteral(resourceName: "Vector-5")
        
        return image
    }()
    var textSize: CGFloat = 12
    var scoreLabel : Label!
    
    var size : StarSize
    init(size: StarSize){
        self.size = size
        super.init(frame: .zero)
        
        if size == .small{
            textSize = 10
        }
        scoreLabel = Label(title: "4.3", type: .Medium, textSize: textSize, changedDefaultColor: #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1))
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        addSubview(starImageView)
        starImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(self.size == .small ? 7 : 10)
            make.top.left.bottom.equalToSuperview()
        }
        addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { (make) in
            make.left.equalTo(starImageView.snp.right).offset(4)
            make.right.bottom.top.equalToSuperview()
        }
    }
}
