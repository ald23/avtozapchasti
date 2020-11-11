//
//  RecentlyCalledViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/18/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class RecentlyCalledViewController: LoaderBaseViewController {
    
    var navBar = NavigationBar(title: "Мне звонили".localized(), rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "feather_chevron-left"))
    
    var calls = [CallsDataParametersModel]()

    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        setupTableView()
        getCalls()
    }
    func setupTableView(){
        tableView.register(RecentlyCalledTableViewCell.self, forCellReuseIdentifier: RecentlyCalledTableViewCell.cellIdentifier())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    func setupAction(){
        navBar.leftButtonAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    func setupView(){
        view.backgroundColor = .white
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(AppConstants.totalNavBarHeight * 1.5)
        }
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(22)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalToSuperview()
        }
        
    }
}
extension RecentlyCalledViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentlyCalledTableViewCell.cellIdentifier(), for: indexPath) as! RecentlyCalledTableViewCell
        
        cell.selectionStyle = .none
        cell.setupData(data: calls[indexPath.row])


        
        return cell

        
        
    }
    
    
}

extension RecentlyCalledViewController {
    private func getCalls() {

        showLoader()

        ParseManager.shared.getRequest(url: AppConstants.API.getCallUser, success: { (result: getCallNotification) in
            self.hideLoader()

            self.calls = result.data

            self.tableView.reloadData()

        }) { (error) in
            self.showErrorMessage(messageType: .error, error)
        }

    }


}
