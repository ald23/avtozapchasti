//
//  MainPageViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/10/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class MainPageViewController : UIViewController{
    var navBar = NavigationBar(title: "Главная".localized(), rightButtonImage : #imageLiteral(resourceName: "Vector-10"), leftButtonImage:  #imageLiteral(resourceName: "Group-1"))
    var tableView = UITableView()

    var orders = [PostData]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var nextViewController = PostDetailViewController()
    var afterNextViewController = OrderAcceptedViewController()
    private var searchViewController = SearchFilterViewController()

    var postButton : MainButton = {
        let button = MainButton(title: "Новое обьявление".localized())
            button.setImage(#imageLiteral(resourceName: "bi_clipboard-plus"), for: .normal)
            button.imageEdgeInsets.right = 140
        
        return button
    }()
    
    var searchButton : MainButton = {
        let button = MainButton(title: "Поиск объявлений".localized())
            button.setImage(#imageLiteral(resourceName: "bi_clipboard-plus"), for: .normal)
            button.imageEdgeInsets.right = 140
        
        return button
    }()

    
    var flyImageView : UIImageView = {
        var image = UIImageView()
        image.image = #imageLiteral(resourceName: "Frame 56")
        return image
    }()
    
    var leaveMessageLabel = Label(title: "Создайте заявку, чтобы получать отклики от свободных СТО и продавцов автозапчастей".localized(), type: .Medium,textSize: 16, aligment:  .center)
    
    var leaveMessageLabelSearch = Label(title: "Найдите нужное Вам объявление, используя фильтр", type: .Medium,textSize: 16, aligment:  .center)

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        getMyPosts()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        setupTableView()
        if UserManager.shared.isSeller(){
            postButton.isHidden = true
            leaveMessageLabel.isHidden = true

        }else{
            navBar.rightButton.isHidden = true
            searchButton.isHidden = true
            leaveMessageLabelSearch.isHidden = true


        }
    }
    
    func setupAction(){
        
        navBar.rightButtonTarget = {
            self.navigationController?.pushViewController(self.searchViewController, animated: true)
        }
        
        searchButton.action = { [weak self] in
            self?.navigationController?.pushViewController(self!.searchViewController,animated: true)
        }

        navBar.leftButtonAction = {
             self.sideMenuController?.showLeftViewAnimated()
        }
        let vc =  AddPostViewController().inNavigation()
            vc.modalPresentationStyle = .fullScreen
            postButton.action = { [weak self] in
            self?.navigationController?.present(vc,animated: true)
        }
        
        
        
        searchViewController.showSeaarchingList = { [weak self] list in
            guard let `self` = self else { return }
            self.orders = list
            self.tableView.reloadData()
            self.leaveMessageLabel.isHidden = true
            self.leaveMessageLabelSearch.isHidden = true
//            self.searchButton.isHidden = true
            self.flyImageView.isHidden = true
        }
        
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyPostsTableViewCell.self, forCellReuseIdentifier: MyPostsTableViewCell.cellIdentifier())
        tableView.separatorStyle = .none
     
    }

    func setupView(){
        self.view.backgroundColor = .white
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1.5*AppConstants.totalNavBarHeight)
        }
  
        addSubview(postButton)
        postButton.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(24)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(52)
        }
        
        addSubview(searchButton)
        searchButton.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(24)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(52)
        }

    
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(postButton.snp.bottom).offset(20)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalToSuperview()
        }

        addSubview(flyImageView)
        flyImageView.snp.makeConstraints { (make) in
            make.height.equalTo(160)
            make.width.equalTo(60)
            make.top.equalTo(postButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview().offset(20)
        }
        addSubview(leaveMessageLabel)
        leaveMessageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(flyImageView.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        
        addSubview(leaveMessageLabelSearch)
        leaveMessageLabelSearch.snp.makeConstraints { (make) in
            make.top.equalTo(flyImageView.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }

  
        
    }
}


extension MainPageViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPostsTableViewCell.cellIdentifier(), for: indexPath) as! MyPostsTableViewCell
        cell.selectionStyle = .none
        cell.setupData(data: orders[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nextViewController.id = orders[indexPath.row].id!
        afterNextViewController.id = orders[indexPath.row].id!

        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }

}

