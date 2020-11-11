//
//  BoldLabel.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/11/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit
enum LabelType {
    case Bold
    case Regular
    case Medium
}
class Label: UILabel {

    init(title: String, type: LabelType , textSize : CGFloat? = nil, aligment: NSTextAlignment = .left,changedDefaultColor: UIColor? = nil) {
        super.init(frame: .zero)
        numberOfLines = 0
    
        self.textAlignment = aligment
        
        self.text = title
        if type == .Bold{
            self.textColor = #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.3019607843, alpha: 1)
            if textSize != nil{
                self.font = .getMontserratBold(of: textSize!)
            }
            else {
                self.font = .getMontserratBold(of: 31)
            }
        }
        else if type == .Regular{
            self.textColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
            if textSize != nil{
                self.font = .getMontserratRegular(of: textSize!)
            }
            else {
                self.font = .getMontserratRegular(of: 14)
            }
        }
        else if type == .Medium {
            self.textColor = #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.3019607843, alpha: 1)
            if textSize != nil{
                self.font = .getMontserratMedium(of: textSize!)
            }
            else {
                self.font = .getMontserratMedium(of: 12)
            }
        }
        
        if changedDefaultColor != nil{
             self.textColor = changedDefaultColor!
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
