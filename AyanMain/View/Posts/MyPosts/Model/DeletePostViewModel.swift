//
//  DeletePostViewModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 9/24/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

class DeletePostViewModel: ViewModelConfigurable {
    
    var errorMessage: String = "Заполните поля".localized()
    var parameters  : Parameters = [:]
    
    private var orderId: Int = Int()
    
    
    func setDeleteOrderId(_ orderId: Int) -> Void {
        self.orderId = orderId
        
    }
    
        
    func isValid() -> Bool {
        true
    }
    
    
    func getParameters() -> Parameters? {
        
        parameters["order_id"] = orderId
        
        return parameters
    }
    
    
    
    
    
}
