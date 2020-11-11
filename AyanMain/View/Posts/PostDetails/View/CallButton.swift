//
//  CallButton.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/13/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class CallButton: UIButton {
    var callAction : (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.cornerRadius = 16
        layer.borderColor = #colorLiteral(red: 0.1450980392, green: 0.4509803922, blue: 0.8352941176, alpha: 1)
        layer.borderWidth = 1
        setImage(#imageLiteral(resourceName: "Vector-4"), for: .normal)
        addTarget(self, action: #selector(callButtonAction), for: .touchUpInside)
    }
    @objc func callButtonAction(){
        callAction?()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
