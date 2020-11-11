//
//  ChangePasswordViewModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 8/26/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

class ChangePasswordViewModel: ViewModelConfigurable {
        
    var errorMessage: String = "Заполните поля".localized()
    var parameters  : Parameters = [:]

    var password_old:       String = String()
    var password_new:       String = String()
    var password_confirm:   String = String()
    
    func setPasswordOld(_ password_old: String) -> Void {
        self.password_old = password_old
    }
    
    func setPasswordNew(_ password_new: String) -> Void {
        self.password_new = password_new
    }
    
    func setPasswordConfirm(_ password_confirm: String) -> Void {
        self.password_confirm = password_confirm
    }

    
    
    func isValid() -> Bool {
        guard password_old     != "" else { errorMessage = "Введите старый пароль"; return false}
        guard password_new     != "" else { errorMessage = "Введите новый пароль"; return false}
        
        return true
        
    }
    

    func getParameters() -> Parameters? {
        parameters["password_old"]        = password_old == "" ? nil : password_old
        parameters["password_new"]         = password_new == "" ? nil : password_new

        return parameters
    }

    
}
