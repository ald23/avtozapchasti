//
//  CodeConfirmationViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/11/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class CodeConfirmationViewController: LoaderBaseViewController {
    var headerView = HeaderView(topLabelText: "Подтверждение".localized(), subLabelText: "Подтвердите свой номер телефона, вводив 4-х значный код, который мы вам отправили на соответсвующий номер".localized())
    var codeConfirm = VerifyCodeView()
    var runCount = 30
    var resendCodeLabel : UILabel = {
        var label = UILabel()
            label.textColor = #colorLiteral(red: 0.1450980392, green: 0.4509803922, blue: 0.8352941176, alpha: 1)
            label.font = .getMontserratRegular(of: 12)
        
        return label
    }()
    var sendButton = MainButton(title: "Отправить".localized())
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTimer()
        setupAction()
    }
    func setupAction(){
        sendButton.action = {
            self.navigationController?.pushViewController(CreateNewPasswordViewController(), animated: true)
        }
    }
    func setupTimer(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.runCount -= 1
            if self.runCount > 9{
                self.resendCodeLabel.text = "Отправить код повторно через 00:".localized() + "\(self.runCount)"
            }
                else {
                self.resendCodeLabel.text = "Отправить код повторно через 00:0".localized() + "\(self.runCount)"
            }
            if self.runCount == 0{
                timer.invalidate()
                self.resendCodeLabel.text = "Отправить код повторно".localized()
            }
        }
    }
    
    func setupViews(){
        view.backgroundColor = .white
        contentView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(240)
            make.right.equalTo(-16)
            make.left.equalTo(16)
        }
        contentView.addSubview(codeConfirm)
        codeConfirm.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(88)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        contentView.addSubview(resendCodeLabel)
        resendCodeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(codeConfirm.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        contentView.addSubview(sendButton)
        sendButton.snp.makeConstraints { (make) in
            make.top.equalTo(resendCodeLabel.snp.bottom).offset(80)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(52)
            make.bottom.equalTo(0)
        }
    }
    


}
