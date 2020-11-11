//
//  ChooseCategoryViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/17/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class ChooseCategoryViewController: LoaderBaseViewController {

    
    var id = 0
    var navBar = NavigationBar(title: "Выберите категорию".localized(), rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "feather_chevron-left"))
    var tableView = UITableView()
   // var sectionNamesArray = [AddingServicesCatListModel]()
    var viewModel = CategoryViewModel()
    var selectedByUserArray = [String]()
    
    var selectedCells = [Int]()
    var readyButton = MainButton(title: "Готово".localized())
    var readyAction : (([AddingServicesCatListModel])->())?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getServicesList(id: id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupAction()
        bind()
        
    }
    func bind(){
        viewModel.categories.observe(on: self) { (result) in
            self.tableView.reloadData()
        }
    }
    func setupAction(){
        navBar.leftButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
        readyButton.action = {
            self.readyAction?(self.viewModel.categories.value)
            self.navigationController?.popToRootViewController(animated: true)
        }
    
    }
    
    func setupView(){
        view.backgroundColor = .white
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(AppConstants.totalNavBarHeight * 1.5)
        }
        contentView.addSubview(readyButton)
        readyButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-20)
            make.left.equalTo(16)
            make.height.equalTo(52)
            make.right.equalTo(-16)
        }
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(AppConstants.totalNavBarHeight * 1.5 + 24)
            make.right.equalToSuperview()
            make.left.equalTo(16)
            make.height.equalTo(90) //number of cells by cell's height
            make.bottom.equalTo(readyButton.snp.top).offset(-40)
        }

        
    }
    func setupTableView(){
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: LanguageTableViewCell.cellIdentifier())
    }
    
}
extension ChooseCategoryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.cellIdentifier(), for: indexPath) as! LanguageTableViewCell
        
            cell.setupData(data: viewModel.categories.value[indexPath.row])
            cell.isselected = selectedCells.contains(indexPath.row)
            cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !selectedCells.contains(indexPath.row){
            selectedCells.append(indexPath.row)
            tableView.reloadData()
//            selectedByUserArray.append(sectionNamesArray[indexPath.row])
        }
        else {
            selectedCells = selectedCells.filter(){$0 != indexPath.row}
//            selectedByUserArray = selectedByUserArray.filter(){$0 != sectionNamesArray[indexPath.row]}
            tableView.reloadData()
        }
    }
    
}

