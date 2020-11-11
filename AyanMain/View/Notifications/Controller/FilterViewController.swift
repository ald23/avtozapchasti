//
//  FilterViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/18/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    var navBar = NavigationBar(title: "Фильтр".localized(), rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "feather_chevron-left"))
    var searchView = SearchView()
    var infoLabel = Label(title: "Выберите категории автомобилей, от которых вы хотите получать уведомления ".localized(), type: .Regular, changedDefaultColor: #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1))
    var tableView = UITableView()
    var sectionNamesArray = ["Lexus","Toyota","Mersedes","BMW","Audi","Audi","Kia","Porsche","McLaren","Lexus","Toyota","Mersedes","BMW","Audi","Audi","Kia","Porsche","McLaren"]
    var selectedCells = [Int]()
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
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(12)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
            make.left.right.equalTo(infoLabel)
            make.height.equalTo(40)
        }
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchView.snp.bottom).offset(26)
            make.right.equalToSuperview()
            make.left.equalTo(16)
            make.bottom.equalToSuperview()
        }
    }

    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: LanguageTableViewCell.cellIdentifier())
        
    }
}
extension FilterViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            sectionNamesArray.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.cellIdentifier(), for: indexPath) as! LanguageTableViewCell
            cell.languageLabel.text = sectionNamesArray[indexPath.row]
            cell.isselected = selectedCells.contains(indexPath.row)
            cell.selectionStyle = .none
            
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !selectedCells.contains(indexPath.row){
            selectedCells.append(indexPath.row)
            tableView.reloadData()
        }
        else {
            selectedCells = selectedCells.filter(){$0 != indexPath.row}
            tableView.reloadData()
        }
    }
        
        
}
