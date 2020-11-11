//
//  VerifyCodeView.swift
//  Flat.kz
//
//  Created by Eldor Makkambayev on 4/1/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class VerifyCodeView: UIView {

//    MARK: - Properties
    
    lazy var firstInputView = CodeVarficationTextField()
    
    lazy var secondInputView = CodeVarficationTextField()

    lazy var thirdInputView = CodeVarficationTextField()
    
    lazy var fourthInputView = CodeVarficationTextField()
    
    var onFourthInputViewChange : (()->())?
    

//    MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupAction(){
        firstInputView.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        secondInputView.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        thirdInputView.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        fourthInputView.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
    }
    
//    MARK: - Setup functions
    
    private func setupView() -> Void {
        addSubview(secondInputView)
        secondInputView.snp.makeConstraints { (make) in
            make.right.equalTo(snp.centerX).offset(-8)
            make.top.bottom.equalToSuperview()
            make.height.width.equalTo(60)
        }
        
        addSubview(firstInputView)
        firstInputView.snp.makeConstraints { (make) in
            make.right.equalTo(secondInputView.snp.left).offset(-16)
            make.top.left.bottom.equalToSuperview()
            make.height.width.equalTo(60)
        }

        addSubview(thirdInputView)
        thirdInputView.snp.makeConstraints { (make) in
            make.left.equalTo(snp.centerX).offset(8)
            make.top.bottom.equalToSuperview()
            make.height.width.equalTo(60)
        }
        
        addSubview(fourthInputView)
        fourthInputView.snp.makeConstraints { (make) in
            make.left.equalTo(thirdInputView.snp.right).offset(16)
            make.top.right.bottom.equalToSuperview()
            make.height.width.equalTo(60)
        }


    }
    
    //MARK: - @objc function
    @objc func textFieldDidChange(textField: UITextField) {
        firstInputView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        secondInputView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        thirdInputView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        fourthInputView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        
        firstInputView.textColor = .black
        secondInputView.textColor = .black
        thirdInputView.textColor = .black
        fourthInputView.textColor = .black
        
        let text = textField.text
        if text?.count == 1 {
            switch textField {
            case firstInputView:
                secondInputView.textColor = .white
                secondInputView.becomeFirstResponder()
                secondInputView.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.4509803922, blue: 0.8352941176, alpha: 1)
                
            case secondInputView:
                thirdInputView.textColor = .white
                thirdInputView.becomeFirstResponder()
                thirdInputView.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.4509803922, blue: 0.8352941176, alpha: 1)
                
            case thirdInputView:
                fourthInputView.textColor = .white
                fourthInputView.becomeFirstResponder()
                fourthInputView.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.4509803922, blue: 0.8352941176, alpha: 1)

            case fourthInputView:
                fourthInputView.resignFirstResponder()
                
            default:
                break
            }
        }
        if text?.count == 0 {
            switch textField {
            case secondInputView:
                firstInputView.becomeFirstResponder()
            case thirdInputView:
                secondInputView.becomeFirstResponder()
            case fourthInputView:
                thirdInputView.becomeFirstResponder()
            default:
                break
            }
        }
    }

}

extension VerifyCodeView : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onFourthInputViewChange?()
    }
    
}
class CodeVarficationTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.cornerRadius = 5
        
        keyboardType = .numberPad
        textAlignment = .center
        font = .getMontserratMedium(of: 22)
        textColor = .white
        backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


