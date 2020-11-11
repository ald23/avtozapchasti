//
//  PostViewModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 9/2/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

class AddPostViewModel: ViewModelConfigurable {
    
    var errorMessage: String = "Заполните поля".localized()
    var parameters  : Parameters = [:]
    
    private var type:                 String = "DETAIL"
    private var brandModelId:         String = String()
    private var year:                 String = String()
    private var time:                 String = String()
    private var price:                String = String()
    private var cityId:               String = String()
    private var description:          String = String()
    private var serviceList:          [Int] = []
    
    
    func setType(_ type: String) -> Void {
        self.type = type
    }
    
    func setBrand(_ brandModelId: String) -> Void {
        self.brandModelId = brandModelId
    }
    
    func setYear(_ year: String) -> Void {
        self.year = year
    }
    
    
    
    
    
    func setTime(_ time: String) -> Void {
        self.time = time
    }
    
    func setPrice(_ price: String) -> Void {
        self.price = price
    }
    
    func setServices(_ serviceList: [Int]) -> Void {
        self.serviceList = serviceList
    }
    
    func setCity(_ id: String) -> Void {
        self.cityId = id
    }
    
    func setDescription(_ description: String) -> Void {
        self.description = description
    }
    
    
    
    func isValid() -> Bool {
        true
    }
    
    
    func getParameters() -> Parameters? {
        //        guard isValid() else {return nil}
        parameters["type"]                      = type
        parameters["brand_model_id"]            = brandModelId
        parameters["year"]                      = year
        for i in 0...serviceList.count - 1 {
            parameters["services[\(i)]"] = serviceList[i]
        }
        parameters["time"]                      = time
        parameters["price"]                     = price
        parameters["city_id"]                   = cityId
        parameters["description"]               = description
       
        
        return parameters
    }
    
    
    
    
    
}
