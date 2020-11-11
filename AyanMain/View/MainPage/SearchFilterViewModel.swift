//
//  SearchFilterViewModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 9/22/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

class SearchFilterViewModel: ViewModelConfigurable {
    
    var errorMessage: String = "Заполните поля".localized()
    var parameters  : Parameters = [:]
    
    private var type:                 String = "DETAIL"
    private var brandModelId:         String = String()
    private var year:                 String = String()
    private var city_id:               String = String()
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

    func setServices(_ serviceList: [Int]) -> Void {
        self.serviceList = serviceList
    }
    
    func setCity(_ city_id: String) -> Void {
        self.city_id = city_id
    }
    
    func isValid() -> Bool {
        true
    }
    
    
    func getParameters() -> Parameters? {
        //        guard isValid() else {return nil}
        parameters["type"]                      = type == "" ? nil : type
        parameters["brand_model_id"]            = brandModelId == "" ? nil : brandModelId
        parameters["year"]                      = year == "" ? nil : year
//        for i in 0...serviceList.count - 1 {
//            parameters["services[\(i)]"] = serviceList[i]
//        }
        parameters["city_id"]                   = city_id == "" ? nil : city_id
        
        return parameters
    }
    
    
    
    
    
}
