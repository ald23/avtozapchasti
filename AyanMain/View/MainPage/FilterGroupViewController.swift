//
//  FilterGroupCategoryViewController.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 9/26/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit



class FilterGroupViewController: LoaderBaseViewController {



    var navBar = NavigationBar(title: "Выберите группу".localized(), rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "feather_chevron-left"))
    var tableView = UITableView()
    
    var sectionNamesArray = [AddingServicesListModel]()


    var nextViewController = FilterCategoryViewController()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getServicesList()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
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
            make.height.equalTo(AppConstants.totalNavBarHeight * 1.5)
        }
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(AppConstants.totalNavBarHeight * 1.5 + 20)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(0)
        }
    }
    func setupTableView(){
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: GroupTableViewCell.cellIdentifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none

    }
}
extension FilterGroupViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionNamesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.cellIdentifier(), for: indexPath) as! GroupTableViewCell
            cell.selectionStyle = .none
        cell.setupData(data: sectionNamesArray[indexPath.row])

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nextViewController.id = sectionNamesArray[indexPath.row].id
        nextViewController.popBackClosure = {
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

}

extension FilterGroupViewController {


    private func getServicesList() {
        self.showLoader()
        ParseManager.shared.getRequest(url: AppConstants.API.getServices, success: { (result: [AddingServicesListModel]) in
            self.sectionNamesArray = result
            self.tableView.reloadData()
        }) { (error) in
            self.showErrorMessage(error)
        }
    }

}
