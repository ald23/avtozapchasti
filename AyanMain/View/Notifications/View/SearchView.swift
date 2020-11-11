//
//  SearchView.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/18/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit


class SearchView: UIView {
     //MARK: - properties
    var searchImage : UIImageView = {
        var image = UIImageView()
            image.image = #imageLiteral(resourceName: "feather_search")
            image.contentMode = .left
        
        return image
    }()
    var detectChanges : ((Bool)->())?
    
    var searchTextView : UITextField = {
        var textView = UITextField()
            textView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
            textView.layer.cornerRadius = 20
            textView.textColor = #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.3019607843, alpha: 1)
            let atr : [NSAttributedString.Key : Any] =  [NSAttributedString.Key.foregroundColor:   #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.3019607843, alpha: 0.5),
                                                           NSAttributedString.Key.font: UIFont.getMontserratMedium(of: 14)]
            textView.attributedPlaceholder = NSAttributedString(string: "Поиск".localized(), attributes: atr)
        
        return textView
    }()
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        searchTextView.delegate = self
        self.backgroundColor =  #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        self.layer.cornerRadius = 20
        setupView()
       
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - setup
    func setupView(){
        addSubview(searchImage)
        searchImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(9)
            make.left.equalTo(10)
            make.width.height.equalTo(20)
        }
        addSubview(searchTextView)
        searchTextView.snp.makeConstraints { (make) in
            make.left.equalTo(searchImage.snp.right).offset(3)
            make.top.bottom.right.equalToSuperview()
        }
    }
    
    
}

extension SearchView : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
          detectChanges?(searchTextView.text == nil)
    }
}
