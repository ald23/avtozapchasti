//
//  MyPostsViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class MyPostsViewController: LoaderBaseViewController {
    
        
    private var viewModel = DeletePostViewModel()

    
    var orders = [PostData]()
    
    var nextViewController = PostDetailViewController()
    var afterNextViewController = OrderAcceptedViewController()
    var navBar = NavigationBar(title: "Мои объявления".localized(), leftButtonImage: #imageLiteral(resourceName: "Group-1"))
    var tableView = UITableView()
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getMyPosts()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        setupAction()
        
    }
    func setupAction(){
        navBar.leftButtonAction = {
             self.sideMenuController?.showLeftViewAnimated()
        }
//        deleteButton.addTarget(self, action: #selector(tapDelete), for: .touchUpInside)


    }
    

    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyPostsTableViewCell.self, forCellReuseIdentifier: MyPostsTableViewCell.cellIdentifier())
        tableView.separatorStyle = .none
    }
    func setupViews(){
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1.5*AppConstants.totalNavBarHeight)
        }
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(20)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension MyPostsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPostsTableViewCell.cellIdentifier(), for: indexPath) as! MyPostsTableViewCell
        cell.selectionStyle = .none 
        cell.setupData(data: orders[indexPath.row])
        
        cell.deleteMyPost = { id in
            print(id)
            self.showAlertWithAction(title: "Вы действительно хотите удалить?", message: "") {
                self.deleteMyPost(id: id)
                self.getMyPosts()
                self.getMyPostsAgain()
            }

        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nextViewController.id = orders[indexPath.row].id!

//        afterNextViewController.id = orders[indexPath.row].id!
//        nextViewController.user_id = orders[indexPath.row].user_id!
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }

    
    
}

extension MyPostsViewController {
    private func getMyPosts() {
        
        showLoader()

        ParseManager.shared.multipartFormData(url: AppConstants.API.getByUser, success: { (result: PostDetailModels?) in
            self.hideLoader()
            
            self.orders = result!.order!

            self.tableView.reloadData()

        }) { (error) in
            self.showErrorMessage(messageType: .error, error)
        }

    }
    
    private func deleteMyPost(id : Int) {

        showLoader()

        ParseManager.shared.multipartFormData(url: AppConstants.API.deletePost, parameters: ["order_id": id], success: { (result: PostData?) in
            self.hideLoader()

            

            self.tableView.reloadData()

        }) { (error) in
            self.showErrorMessage(messageType: .deleteSuccess, error)
        }

    }
    
    private func getMyPostsAgain() {
        
        showLoader()

        ParseManager.shared.multipartFormData(url: AppConstants.API.getByUser, success: { (result: PostDetailModels?) in
            self.hideLoader()
            
            self.orders = result!.order!

            self.tableView.reloadData()

        }) { (error) in
            self.showErrorMessage(messageType: .error, error)
        }

    }

    
    

}
