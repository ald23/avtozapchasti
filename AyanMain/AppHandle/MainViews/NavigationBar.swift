//
//  NavigationBar.swift
//  
//
//  Created by Bakdaulet Myrzakerov on 7/29/20.
//

import UIKit

class NavigationBar : UIView {
    var rightButtonImage: UIImage?
    var leftButtonImage: UIImage?
  
    var leftButtonAction: (() -> ())?
    var rightButtonTarget: (() -> ())?
    
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
            button.setImage(leftButtonImage, for: .normal)
            button.contentMode = .scaleAspectFit
            button.imageEdgeInsets.top = 1
            button.imageEdgeInsets.left = 1
            button.imageEdgeInsets.right = -1
            button.imageEdgeInsets.bottom = -1
            button.layer.cornerRadius = 13
            
        
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
            button.setImage(rightButtonImage, for: .normal)
            button.contentMode = .scaleAspectFit
            button.layer.cornerRadius = 13
            button.imageEdgeInsets.top = 1
            button.imageEdgeInsets.left = 1
            button.imageEdgeInsets.right = -1
            button.imageEdgeInsets.bottom = -1
        
        return button
    }()
    

    lazy var titleLabel: UILabel = {
        let label = UILabel()
            label.textColor = #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.3019607843, alpha: 1)
            label.font = .getMontserratBold(of: 27)
            label.textAlignment = .left
            label.numberOfLines = 0
        
        return label
    }()
    
    //    MARK: - Initialization
    
    init(title: String = "", rightButtonImage: UIImage? = nil, leftButtonImage:UIImage? = nil) {
        super.init(frame: .zero)
        
        self.rightButtonImage = rightButtonImage
        self.leftButtonImage = leftButtonImage
        
        
        self.titleLabel.text = title
        
        setupAction()
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    MARK: - Setup function
    private func setupAction(){
        leftButton.addTarget(self, action: #selector(leftButtonActionButton), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
      
    }
    private func setupView() -> Void {

        self.leftButton.isHidden = leftButtonImage == nil
        self.rightButton.isHidden = self.rightButtonImage == nil
        self.backgroundColor = .white
        addSubview(leftButton)
        leftButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            if !(self.titleLabel.text == "")
            {
                make.top.equalTo(AppConstants.totalNavBarHeight/2)
            }
            else {
                make.centerY.equalToSuperview().offset(20)
            }
           
            make.height.width.equalTo(AppConstants.navBarHeight*4/5)
        }
        addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(AppConstants.totalNavBarHeight/2)
            make.height.width.equalTo(leftButton)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rightButton.snp.bottom).offset(AppConstants.totalNavBarHeight/4)
            make.left.equalTo(leftButton).offset(6)
            make.right.equalTo(-10)
        }
        
    }
    
    @objc func leftButtonActionButton() -> Void {
        self.leftButtonAction?()
    }
    
    @objc func rightButtonAction() -> Void {
        self.rightButtonTarget?()
    }

}
