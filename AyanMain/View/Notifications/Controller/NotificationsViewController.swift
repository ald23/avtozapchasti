//
//  NotificationsViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class NotificationsViewController: LoaderBaseViewController {
    

    var calls : [CallsDataParametersModel] = [] {
        didSet {
        tableView.reloadData()
        }
    }

    var navBar = NavigationBar(title: "Уведомления".localized(), rightButtonImage : #imageLiteral(resourceName: "Vector-10"), leftButtonImage:  #imageLiteral(resourceName: "Group-1"))
    var tableView = UITableView()
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        setupAction()
        getCalls()
    }
    func setupAction(){
        navBar.leftButtonAction = {
             self.sideMenuController?.showLeftViewAnimated()
        }
        navBar.rightButtonTarget = {
            self.navigationController?.pushViewController(FilterViewController(), animated: true)

        }
    }
    func setupTableView(){
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.cellIdentifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    func setupViews(){
        view.backgroundColor = .white
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(AppConstants.totalNavBarHeight * 1.5)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(AppConstants.totalNavBarHeight * 1.5 + 24)
            make.bottom.equalToSuperview()
            make.right.equalTo(-16)
            make.left.equalTo(16)
        }
    
    }

}
extension NotificationsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.cellIdentifier(), for: indexPath) as! NotificationTableViewCell
        cell.setupData(data: calls[indexPath.row])

            cell.selectionStyle = .none
        
        return cell
    }
    
    
}

extension NotificationsViewController {
    private func getCalls() {

      

        ParseManager.shared.getRequest(url: AppConstants.API.getCallUser, success: { (result: getCallNotification) in
           
        self.calls = result.data



        }) { (error) in
           
        }

    }
}
