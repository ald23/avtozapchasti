//
//  MainPageAddPostViewController.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/12/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//
import Foundation
import UIKit

class AddPostViewController: LoaderBaseViewController {
    
    private var viewModel = AddPostViewModel()
    
    private var yearList = ["1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020"]
    
    var brandList: [AddingDataListModel] = [] {
        didSet {
            carBrandView.valueList = brandList.map({$0.name})
        }
    }
    
    var modelList: [AddingDataListModel] = [] {
        didSet {
            carModelView.valueList = modelList.map({$0.name})
        }
    }
    
    var cityList: [AddingDataListModel] = [] {
        didSet {
            cityInputView.valueList = cityList.map({$0.name})
        }
    }
    
    
    let navBar = NavigationBar(title: "Новое обьявление".localized(), rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "Group-5"))
    var switcher = SwitcherView(firstTitle: "Детали".localized(), secondTitle: "Услуги".localized())
    
    var carBrandView = InputView(inputType: .plainText, placeholder: "Выбор марки".localized(), righticon: #imageLiteral(resourceName: "Vector-1"), topLabelText: "Марка", isPicker: true)
    var carModelView = InputView(inputType: .plainText, placeholder: "Выбор модели".localized(), righticon: #imageLiteral(resourceName: "Vector-1"), topLabelText: "Модель", isPicker: true)
    var yearReleaseView = InputView(inputType: .plainText, placeholder: "Год выпуска".localized(), righticon: #imageLiteral(resourceName: "Vector-1"), topLabelText: "Год".localized(), isPicker: true)
    
    var topLabel = Label(title: "Деталь или услуга".localized(), type: .Medium)
    var detailView = AddDetailView()
    
    var deadlineView = InputView(inputType: .plainText, placeholder: "3-5 дней", topLabelText: "Срок")
    var priceView = InputView(inputType: .plainText, placeholder: "Предложите свою цену".localized(), topLabelText: "Цена".localized())
    var commentView = InputView(inputType: .plainText, placeholder: "    \nРасскажите подробно о требуемом товаре..".localized(), righticon: nil, topLabelText: "Описание".localized())
    var cityInputView = InputView(inputType: .plainText, placeholder: "Укажите ваш город".localized(), righticon: #imageLiteral(resourceName: "Vector-1"), topLabelText: "Город".localized(), isPicker: true)
    var sendButton = MainButton(title: "Оставить заявку".localized())
    
    
    var nextViewController =  ChooseGroupViewController()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        setupLoaderView()
        setupInputViewsData()
        getBrandList()
    }
    
    func setupAction(){
        navBar.leftButtonAction = {
            self.dismiss(animated: true, completion: nil)
        }
        detailView.gestureTargetAction = {
            self.navigationController?.pushViewController(self.nextViewController, animated: true)
        }
        nextViewController.nextViewController.readyAction = { [unowned self] (array) in
            self.detailView.detailsArray = array
            self.detailView.collectionView.reloadData()
        }
        
        sendButton.action = { [weak self] in
            guard let `self` = self else { return }
            self.tapPost()
        }
        
        switcher.firstAction = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.setType("DETAIL")
            
        }
        
        switcher.secondAction = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.setType("SERVICE")
        }
        
    }
    
    private func setupInputViewsData() {
        yearReleaseView.valueList = yearList
        priceView.textField.keyboardType = .decimalPad
        
        
        carBrandView.pickerSelectBlock = { [weak self] index in
            guard let `self` = self else { return }
            guard index != -1 else {return}
            self.getModelList(by: self.brandList[index].id)
        }
        
        carModelView.pickerSelectBlock = { [weak self] index in
            guard let `self` = self else { return }
            guard index != -1 else { self.viewModel.setBrand(""); return}
            self.viewModel.setBrand("\(self.modelList[index].id)")
        }
        
        yearReleaseView.pickerSelectBlock = { [weak self] index in
            guard let `self` = self else { return }
            guard index != -1 else { self.viewModel.setYear(""); return}
            self.viewModel.setYear("\(self.yearList[index])")
        }
        
        cityInputView.pickerSelectBlock = { [weak self] index in
            guard let `self` = self else { return }
            guard index != -1 else { self.viewModel.setCity(""); return}
            self.viewModel.setCity("\(self.cityList[index].id)")
        }

    }
    
    func setupView(){
        view.backgroundColor = .white
        addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1.5*AppConstants.totalNavBarHeight)
        }
        contentView.addSubview(switcher)
        switcher.snp.makeConstraints { (make) in
            make.top.equalTo(1.5*AppConstants.totalNavBarHeight + 22)
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.height.equalTo(48)
        }
        contentView.addSubview(carBrandView)
        carBrandView.snp.makeConstraints { (make) in
            make.top.equalTo(switcher.snp.bottom).offset(32)
            make.left.right.equalTo(switcher)
            make.height.equalTo(68)
        }
        contentView.addSubview(carModelView)
        carModelView.snp.makeConstraints { (make) in
            make.top.equalTo(carBrandView.snp.bottom).offset(12)
            make.left.right.height.equalTo(carBrandView)
        }
  
        contentView.addSubview(yearReleaseView)
        yearReleaseView.snp.makeConstraints { (make) in
            make.top.equalTo(carModelView.snp.bottom).offset(12)
            make.left.right.height.equalTo(carBrandView)
        }
        contentView.addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(yearReleaseView.snp.bottom).offset(12)
            make.left.equalTo(yearReleaseView)
        }
        contentView.addSubview(detailView)
        detailView.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(8)
            make.left.right.height.equalTo(carBrandView)
        }
        contentView.addSubview(deadlineView)
        deadlineView.snp.makeConstraints { (make) in
            make.top.equalTo(detailView.snp.bottom).offset(12)
            make.left.right.height.equalTo(carBrandView)
        }
        contentView.addSubview(priceView)
        priceView.snp.makeConstraints { (make) in
            make.top.equalTo(deadlineView.snp.bottom).offset(12)
            make.left.right.height.equalTo(carBrandView)
        }
        contentView.addSubview(commentView)
        commentView.snp.makeConstraints { (make) in
            make.top.equalTo(priceView.snp.bottom).offset(12)
            make.left.right.equalTo(carBrandView)
            make.height.equalTo(100)
        }
        contentView.addSubview(cityInputView)
        cityInputView.snp.makeConstraints { (make) in
            make.top.equalTo(commentView.snp.bottom).offset(12)
            make.left.right.height.equalTo(carBrandView)
 
        }
        contentView.addSubview(sendButton)
        sendButton.snp.makeConstraints { (make) in
            make.top.equalTo(cityInputView.snp.bottom).offset(40)
            make.left.right.equalTo(cityInputView)
            make.height.equalTo(52)
            make.bottom.equalTo(0)
        }
 
    }
    
    private func tapPost() -> Void {
        setNewPost()


    }

}


extension AddPostViewController {
    
    
    private func setNewPost()  {
        
        viewModel.setTime(deadlineView.textField.text!)
        viewModel.setPrice(priceView.textField.text!)
        viewModel.setDescription(commentView.textField.text!)
        viewModel.setServices(detailView.detailsArray.map{($0.id)})
        
        guard viewModel.isValid() else {self.showErrorMessage(messageType: .none, viewModel.errorMessage); return}
        let parameters = viewModel.getParameters()
        showLoader()
        parameters?.forEach({ (key,value) in
            print("key : \(key)\n")
            print("value : \(value)\n\n")
        })

        ParseManager.shared.multipartFormData(url: AppConstants.API.createOrder, parameters: parameters, success: { (result: OrderModel) in
//            self.navigationController?.popToRootViewController(animated: true)
            self.hideLoader()
            
            self.showDissmissAlert(title: "Объявление успешно создано!", message: "Войдите в 'Мои объявления', чтобы проверить") {
                self.dismiss(animated: true, completion: nil)

            }
        }) { (error) in
            self.showErrorMessage(messageType: .error, error)
            self.hideLoader()

        }
    }
    
    private func getBrandList() {
        self.showLoader()
        ParseManager.shared.getRequest(url: AppConstants.API.getBrand, success: { (result: [AddingDataListModel]) in
            self.brandList = result
            self.getCityList()
        }) { (error) in
            self.showErrorMessage(error)
        }
    }
    
    private func getModelList(by brandId: Int) {
        ParseManager.shared.postRequest(url: AppConstants.API.getModelByBrand, parameters: ["brand_id": brandId], success: { (result: [AddingDataListModel]) in
            self.modelList = result
        }) { (error) in
            self.showErrorMessage(error)
        }
    }
    
    private func getCityList() {
        ParseManager.shared.getRequest(url: AppConstants.API.getCities, success: { (result: [AddingDataListModel]) in
            self.cityList = result
            self.hideLoader()
        }) { (error) in
            self.showErrorMessage(error)
        }

    }
    

}
