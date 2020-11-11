//
//  RegisterViewModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 8/25/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

class RegisterViewModel: ViewModelConfigurable {
        
    var errorMessage: String = "Заполните поля".localized()
    var parameters  : Parameters = [:]

    var name:           String = String()
    var phone:          String = String()
    var city_id:        String = String()
    var type:           String = String()
    var password:       String = String()
    var device_type:    String = String()
    var device_token:   String = String()
    

    func setPassword(_ password: String) -> Void {
        self.password = password
    }
    
    func setName(_ name: String) -> Void {
        self.name = name
    }
    
    func setCity(_ city_id: String) -> Void {
        self.city_id = city_id
    }
    
    func setType(_ type: String) -> Void {
        self.type = type
    }
    


    
    func setPhone(_ phone: String) -> Void {
        let phoneNumber = phone.replacingOccurrences(of: "-", with: "")
        self.phone = "\(phoneNumber)"
    }
    
    func isValid() -> Bool {
        guard phone.count > 9 else { errorMessage = "Введите номер телефона"; return false}

//        guard phone    != "" else { errorMessage = "Введите номер телефона"; return false}
        guard password != "" else { errorMessage = "Введите пароль"; return false}
        guard name     != "" else { errorMessage = "Введите имя"; return false}
        guard city_id  != "" else { errorMessage = "Введите город"; return false}
        guard type     != "" else { errorMessage = "Выберите тип пользования"; return false}

        return true
    }


    func getParameters() -> Parameters? {
//        guard isValid() else {return nil}
        parameters["phone"]        = phone
        parameters["name"]         = name
        parameters["city_id"]      = city_id
        parameters["password"]     = password
        parameters["type"]         = type
//        parameters["device_type"]         = "ios"
//        parameters["device_token"]         = UserManager.getFirebaseToken() ?? ""

//        parameters["token"]        = token

        return parameters
    }

    
}
