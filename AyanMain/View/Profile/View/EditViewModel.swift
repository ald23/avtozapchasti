//
//  EditViewModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 8/26/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

class EditViewModel: ViewModelConfigurable {
        
    var errorMessage: String = "Заполните поля".localized()
    var parameters  : Parameters = [:]

    var avatar:     Data = Data()
    var name:       String = String()
    var phone:      String = String()
    var city_id:    String = String()
    var type:       String = String()

    func setName(_ name: String) -> Void {
        self.name = name
    }
    
    func setCity(_ city_id: String) -> Void {
        self.city_id = city_id
    }
    
    func setType(_ type: String) -> Void {
        self.type = type
    }
    
    func setPhoto(_ avatar: Data) -> Void {
        self.avatar = avatar
    }

    func isValid() -> Bool {
        true
    }
    
    func setPhone(_ phone: String) -> Void {
        let phoneNumber = phone.replacingOccurrences(of: "-", with: "")
        self.phone = "\(phoneNumber)"
    }
    


    func getParameters() -> Parameters? {
        parameters["phone"]        = phone == "" ? nil : phone
        parameters["name"]         = name == "" ? nil : name
        parameters["city_id"]      = city_id == "" ? nil : city_id
        parameters["type"]         = type == "" ? nil : type
    
        return parameters
    }

    
}
