//
//  CreateReviewVIewModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 9/8/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

class CreateReviewViewModel: ViewModelConfigurable {
    
    var errorMessage: String = "Заполните поля".localized()
    var parameters  : Parameters = [:]
    
//    private var user_id:               Int = Int()
//    private var star:                 String = String()
    private var text:                 String = String()
    
//
//    func setUserId(_ user_id: Int) -> Void {
//        self.user_id = user_id
//    }
    
//    func setStar(_ star: String) -> Void {
//        self.star = star
//    }
    
    func setDescription(_ text: String) -> Void {
        self.text = text
    }
    
    
    
    func isValid() -> Bool {
        true
    }
    
    
    func getParameters() -> Parameters? {
        //        guard isValid() else {return nil}
//        parameters["user_id"]                    = user_id
//        parameters["star"]                      = star == "" ? nil : star
        parameters["text"]                      = text
        
        return parameters
    }
    
}
