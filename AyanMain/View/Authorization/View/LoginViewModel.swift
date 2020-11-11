//
//  LoginViewModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 8/24/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

class LoginViewModel: ViewModelConfigurable {
        
    var errorMessage: String = "Заполните поля"
    var parameters  : Parameters = [:]
    var device_type:  String = String()
    var device_token: String = String()

    var phone: String = String()

    var password: String = String()

    func setPassword(_ password: String) -> Void {
        self.password = password
    }
    
    func setPhone(_ phone: String) -> Void {
        let phoneNumber = phone.replacingOccurrences(of: "-", with: "")
        self.phone = "\(phoneNumber)"
    }
    func isValid() -> Bool {
        guard phone.count > 9 else { errorMessage = "Введите номер телефона"; return false}
        guard password != "" else { errorMessage = "Введите пароль"; return false}
        return true
    }

    func getParameters() -> Parameters? {
//        guard isValid() else {return nil}
        parameters["phone"]        = phone
        parameters["password"]     = password
//        parameters["device_type"]         = "ios"
//        parameters["device_token"]         = UserManager.getFirebaseToken() ?? ""
//        parameters["device_token"]         = ";laksdjfs"

//        parameters["token"]        = token

        return parameters
    }

    
}
