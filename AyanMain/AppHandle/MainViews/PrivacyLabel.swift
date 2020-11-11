//
//  PrivacyLabel.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/14/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class PrivacyLabel: UILabel {

    init(selectedColor : UIColor, deselectedColor: UIColor,aligment: NSTextAlignment) {
        super.init(frame: .zero)
        let firstAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:              deselectedColor.cgColor,
                                                              NSAttributedString.Key.font: UIFont.getMontserratMedium(of: 13)]
        
        let secondAttributes : [NSAttributedString.Key : Any] =  [NSAttributedString.Key.foregroundColor:  selectedColor.cgColor,
                                                                  NSAttributedString.Key.font: UIFont.getMontserratMedium(of: 13)

        ]
        
        let firstString = NSMutableAttributedString(string: "Вы согласны ", attributes: firstAttributes)
        let secondString = NSMutableAttributedString(string: "с условиями использования", attributes: secondAttributes)
        let thirdString = NSMutableAttributedString(string: " и ", attributes: firstAttributes)
        let fourthString = NSMutableAttributedString(string: " политики конфиденциальности", attributes: secondAttributes)
        let fifthString = NSMutableAttributedString(string: "?", attributes: firstAttributes)
        
        firstString.append(secondString)
        firstString.append(thirdString)
        firstString.append(fourthString)
        firstString.append(fifthString)
        
       
        attributedText = firstString
        numberOfLines = 0
        textAlignment = aligment
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
