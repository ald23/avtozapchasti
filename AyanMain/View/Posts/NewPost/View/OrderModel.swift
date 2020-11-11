//
//  OrderModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 9/15/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - OrderModel
struct OrderModel: Codable {
        
    var id: Int
    var type: String?
    var brand: String?
    var brand_model: String?
    var year: String?
//    var services
    var city: String?
    var user: String?
    var description: String

}

struct UserTypeModel: Codable {
    var type: String?
}


