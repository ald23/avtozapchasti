//
//  PolicyViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/17/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class PolicyViewController: LoaderBaseViewController {

    var navBar = NavigationBar(title: "Условия использования".localized(), leftButtonImage: #imageLiteral(resourceName: "feather_chevron-left"))
    var conditionsLabel = Label(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Interdum eget elit vel nec arcu nunc at in tellus. Commodo in id augue nisi in in volutpat habitant. Lacus volutpat hendrerit sagittis phasellus vitae sit dignissim. Est gravida ut in lorem tristique risus et. Viverra cursus vel a duis. Sem eu neque odio quis dignissim rhoncus tellus arcu, tristique. Pellentesque ultrices ultricies tristique eleifend vitae vestibulum cras. Ridiculus molestie enim sed cursus tristique vulputate blandit vitae. Egestas proin iaculis morbi id pretium euismod odio. Magna eget non pretium et sed et. Viverra sed enim sapien, rhoncus facilisi risus feugiat parturient. Pellentesque pellentesque quam sit enim. Sagittis eros arcu arcu scelerisque tristique cum. Mattis praesent nunc volutpat et. Quisque neque, laoreet morbi vulputate. Integer tempus, ullamcorper commodo mattis. Sit eleifend lectus velit pellentesque. Amet sapien fermentum in sit et convallis. Nec et magna eros egestas in vel tempus scelerisque leo. Fermentum, lacus elit aliquet sagittis pellentesque non lacinia. Viverra aliquet elementum odio nisl nec. Id aliquet enim praesent in lobortis eros. Nulla at mauris, congue euismod aenean at at. Eu sed libero tellus aenean tempor. Aenean congue habitasse lobortis facilisis. Fermentum lacus feugiat scelerisque ut ut imperdiet rhoncus. Nunc rhoncus nunc, felis feugiat in hendrerit sapien, pharetra, pellentesque. Mattis at facilisis in feugiat arcu tincidunt id. Enim urna, velit, pellentesque diam urna libero. Ipsum urna quis facilisis feugiat ac nulla. Nisi viverra sem ac tellus faucibus suspendisse", type: .Regular, textSize: 13)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
    }
    func setupAction(){
        navBar.leftButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func setupView(){
        view.backgroundColor = .white
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(AppConstants.totalNavBarHeight * 1.5 + 40)
        }
        contentView.addSubview(conditionsLabel)
        conditionsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(AppConstants.totalNavBarHeight * 1.5 + 20)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
    }

}
