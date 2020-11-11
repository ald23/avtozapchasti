//
//  MainButton.swift
//  Bus_time_MAIN
//
//  Created by Bakdaulet Myrzakerov on 7/28/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit
enum MainButtonType {
    case gray
    case blue
}
class MainButton: UIButton {
    
    
    var action : (()->())?
    
    init(title: String, type : MainButtonType = .blue) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 4
        titleLabel?.font = .getMontserratMedium(of: 15)
        setTitleColor(.white, for: .normal)
        backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.4509803922, blue: 0.8352941176, alpha: 1)
        if type == .gray {
            self.backgroundColor = .clear
            setTitleColor(#colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1), for: .normal)
        }
    
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton(){
        action?()
    }
}
class BlueButton: UIButton {
    
    var action : (()->())?
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = .getMontserratMedium(of: 13)
        setTitleColor(#colorLiteral(red: 0.1450980392, green: 0.4509803922, blue: 0.8352941176, alpha: 1), for: .normal)
    
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton(){
        action?()
    }
}


