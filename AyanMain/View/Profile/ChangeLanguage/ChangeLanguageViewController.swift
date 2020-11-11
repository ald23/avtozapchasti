
//
//  ChangeLanguageViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/14/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

enum Languages: String {
    case ru = "ru"
    case kz = "kz"
    case en = "en"
}

class ChangeLanguageViewController: UIViewController {
    var navBar = NavigationBar(title: "Изменить язык".localized(), leftButtonImage: #imageLiteral(resourceName: "feather_chevron-left"))
    var tableView = UITableView()
    let languagesArray = ["Русский","Казахский","English"]
    var readyButton = MainButton(title: "Готово".localized())
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
            make.top.equalTo(navBar.snp.bottom).offset(30)
            make.left.equalTo(16)
            make.right.equalToSuperview()
            make.height.equalTo(languagesArray.count * 45)
        }
        addSubview(readyButton)
        readyButton.snp.makeConstraints { (make) in
            make.height.equalTo(52)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-120)
        }
    }
    func setupTableView(){
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: LanguageTableViewCell.cellIdentifier())
    }
    
    private func changeLang(index: Int) -> Void {
        let langList: [Languages] = [.ru, .kz, .en]
        UserDefaults.standard.set(langList[index].rawValue, forKey: Key.language)
        AppCenter.shared.makeRootController()
    }


}
extension ChangeLanguageViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.cellIdentifier(), for: indexPath) as! LanguageTableViewCell
            cell.selectionStyle = .none
        
            cell.isSelected = indexPath.row == 0
            cell.languageLabel.text = languagesArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.changeLang(index: indexPath.row)
    }

}
