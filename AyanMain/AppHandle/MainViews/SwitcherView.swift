//
//  SwitcherView.swift
//  VideoHosting
//
//  Created by Eldor Makkambayev on 1/30/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class SwitcherView: UIView {
    
    //MARK: - Properties
    var firstAction: (() -> ())?
    var secondAction: (() -> ())?
    var thirdAction: (() -> ())?
    
    var isselected = false
    var selectedButton: UIButton? {
        didSet{
            self.isselected = true
            let buttons = [firstButton, secondButton]
            if !isWhite{
                for button in buttons {
                    button.setTitleColor(#colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.3019607843, alpha: 1), for: .normal)
                }
                self.selectedButton!.setTitleColor(#colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1), for: .normal)
            }
            else {
                for button in buttons {
                    button.setTitleColor(#colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1), for: .normal)
                }
                self.selectedButton!.setTitleColor( #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.3019607843, alpha: 1), for: .normal)
                }
            }
        }
    
    lazy var firstButton: UIButton = {
        let button = UIButton()
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .getMontserratMedium(of: 16)
            if isWhite {
                button.setTitleColor(#colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.3019607843, alpha: 1), for: .normal)
                button.backgroundColor = UIColor(red: 0.306, green: 0.282, blue: 0.538, alpha: 0.16)
            }
        return button
    }()
    lazy var secondButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.3019607843, alpha: 1), for: .normal)
            button.titleLabel?.font = .getMontserratMedium(of: 16)
            if isWhite {
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = UIColor(red: 0.306, green: 0.282, blue: 0.538, alpha: 0.16)
            }
        return button
    }()

    lazy var bottomView: UIView = {
        let view = UIView()
            view.layer.cornerRadius = 7
            view.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.4509803922, blue: 0.8352941176, alpha: 1)
        if isWhite{
            view.backgroundColor = .white
        }
        return view
    }()
   
    //MARK: - Initialization
    init(firstTitle: String, secondTitle: String, isWhite : Bool? = false) {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        
        if isWhite != false{
            self.isWhite = isWhite!
            backgroundColor = UIColor(red: 0.306, green: 0.282, blue: 0.538, alpha: 0.16)
        }
        
        firstButton.setTitle(firstTitle, for: .normal)
        secondButton.setTitle(secondTitle, for: .normal)
        setupView()
        setupAction()
    }
    var isWhite = false
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup function
    private func setupView() -> Void {
        self.layer.cornerRadius = 7
            addSubview(bottomView)
            bottomView.snp.makeConstraints { (make) in
                make.left.top.bottom.equalToSuperview()
                make.right.equalTo(snp.centerX)
                make.height.equalTo(40)
                make.bottom.equalToSuperview()
            }

            addSubview(firstButton)
            firstButton.snp.makeConstraints { (make) in
                make.height.equalTo(40)
                make.left.top.bottom.equalToSuperview()
                make.right.equalTo(snp.centerX)
            }
            addSubview(secondButton)
            secondButton.snp.makeConstraints { (make) in
                make.height.equalTo(40)
                make.right.top.bottom.equalToSuperview()
                make.left.equalTo(snp.centerX)
            }
    }
    
    
    private func setupAction() -> Void {
        firstButton.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
       
    }
    

//    MARK: - Simple functions
    func firstButtonSelected() -> Void {
        selectedButton = firstButton
        UIView.animate(withDuration: 0.3) {
            self.bottomView.snp.remakeConstraints { (make) in
                make.left.top.bottom.equalToSuperview()
                make.right.equalTo(self.snp.centerX)
                make.height.equalTo(40)
     
            }
            self.superview?.layoutIfNeeded()
        }
        

        firstAction?()
    }
    
    func secondButtonSelected() -> Void {
        selectedButton = secondButton
        UIView.animate(withDuration: 0.3) {
            self.bottomView.snp.remakeConstraints { (make) in
                make.height.equalTo(40)
                make.right.top.bottom.equalToSuperview()
                make.left.equalTo(self.snp.centerX)
            }
            self.superview?.layoutIfNeeded()
        }
        secondAction?()

    }
    //MARK: - Objective function
    @objc func buttonPressed(sender: UIButton) -> Void {
        if selectedButton != sender {
            if sender == firstButton {
                firstButtonSelected()
            } else if sender == secondButton {
                secondButtonSelected()
            }
   
        }
    }
    
}
