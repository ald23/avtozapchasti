//
//  InputView.swift
//  VideoHosting
//
//  Created by Eldor Makkambayev on 12/19/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit
import UITextView_Placeholder
enum InputTypes {
    case phone
    case plainText
    case secureText
    case comment
    var isSecure: Bool {
        return .secureText == self
    }
}

enum InputViewTypes {
    case email
    case phone
    case iin
    case `default`
}

class InputView: UIView {
    
    //MARK: - Properties
    let inputType: InputTypes
    var placeholder: String
    var isPicker: Bool
    private let rightIcon: UIImage?
  
    var pickerSelectBlock: ((Int) -> ())?
    var iconAction: (() -> ())?
    var didTapAction : (()->())?
    
    var valueList = [String]() {
        didSet {
            self.pickerValueList = [""]
            self.pickerValueList.append(contentsOf: self.valueList)
        }
    }
    
    var pickerValueList: [String] = [""] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    lazy var pickerView: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
            tf.clipsToBounds = true
            tf.tag = 0
            tf.isSecureTextEntry = inputType.isSecure
            tf.borderStyle = .none
            tf.font = .getMontserratRegular(of: 13)
            tf.textColor = .boldTextColor
            tf.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                          attributes: [
                                                            NSAttributedString.Key.foregroundColor:  UIColor.grayForText,
                                                            NSAttributedString.Key.font: UIFont.getMontserratRegular(of: 14)])
            tf.clipsToBounds = true
            tf.layer.cornerRadius = 4
            tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
            tf.leftViewMode = .always
        
        if isPicker {
            tf.inputView = pickerView
        }
        
        return tf
    }()
 
    var plusLabel = Label(title: "+7", type: .Medium, textSize: 14)
    var rightBorderView : UIView = {
        var view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            
        return view
    }()
    lazy var phoneTextField: PhoneTextField = {
        let tf = PhoneTextField()
            tf.tag = 1
            tf.borderStyle = .none
            tf.font = .getMontserratRegular(of: 13)
            tf.textColor = .boldTextColor
            tf.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                      attributes: [
                                                        NSAttributedString.Key.foregroundColor: UIColor.grayForText,
                                                        NSAttributedString.Key.font: UIFont.getMontserratRegular(of: 14)])
            tf.layer.cornerRadius = 4
        
        if isPicker {
            tf.inputView = pickerView
        }
            
        return tf
    }()
    
    lazy var rightIconView: UIImageView = {
        let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.image = rightIcon//.withRenderingMode(.alwaysOriginal)
            iv.isUserInteractionEnabled = true
           
        
        return iv
    }()
    lazy var commentTextView : UITextView = {
        var text = UITextView()
            text.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
            text.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            text.layer.borderWidth = 1
            text.clipsToBounds = true
            text.layer.cornerRadius = 4
            text.contentInset.top = 16
            text.contentInset.left = 20
            text.contentInset.right = 20
            text.textColor = .boldTextColor
            text.placeholder = placeholder
    
        return text
    }()

    var topLabel = Label(title: "on top of textField", type: .Medium)
    
    
    var backView : UIView = {
        var view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
            view.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            view.layer.borderWidth = 1
            view.clipsToBounds = true
            view.layer.cornerRadius = 4
        
        return view
    }()
    //MARK: - Initialization
    init(inputType: InputTypes, placeholder: String, righticon: UIImage? = nil, topLabelText: String, isPicker: Bool = false) {
        self.inputType = inputType
        self.placeholder = placeholder
        self.rightIcon = righticon
        self.topLabel.text = topLabelText
        self.isPicker = isPicker
        super.init(frame: .zero)
        
        layer.cornerRadius = 4
        
        setupViews()
        setupGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Setup functions

    
    private func setupViews() {

        addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalTo(0)
        }
        if inputType == .phone {
            backView.addSubview(plusLabel)
            plusLabel.snp.makeConstraints { (make) in
                make.left.equalTo(20)
                make.top.equalTo(14)
                make.width.equalTo(20)
            }
            backView.addSubview(rightBorderView)
            rightBorderView.snp.makeConstraints { (make) in
                make.top.equalTo(12)
                make.left.equalTo(plusLabel.snp.right).offset(16)
                make.width.equalTo(1)
                make.bottom.equalTo(-12)
            }
            backView.addSubview(phoneTextField)
            phoneTextField.snp.makeConstraints { (make) in
                make.bottom.top.equalTo(0)
                make.left.equalTo(rightBorderView.snp.right).offset(16)
                make.right.equalTo(0)
            }
            
            
            
        } else if inputType == .comment {
            self.backView.addSubview(commentTextView)
            self.commentTextView.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(0)
                make.left.equalTo(0)
                make.right.equalTo(0)
            }
        }
        else {
            self.backView.addSubview(textField)
            self.textField.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(0)
                make.left.equalTo(0)
                make.right.equalTo(0)
            }
        }
            backView.addSubview(rightIconView)
            rightIconView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-26)
                make.height.width.equalTo(14)
            }
    

    }
    
    private func setupGesture() -> Void {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(iconTarget))
        rightIconView.addGestureRecognizer(tapGesture)
    }
    @objc func iconTarget() -> Void {
        iconAction?()
    }


}

extension InputView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerValueList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerValueList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if !valueList.isEmpty {
            textField.text = pickerValueList[row]
            pickerSelectBlock?(row-1)
        }
    }
}
