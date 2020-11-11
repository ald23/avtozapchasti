//
//  PostDetailModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 9/14/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation


struct PostData: Codable {
        var id: Int?
        var type: String?
        var brand: String?
        var brand_model: String?
        var year: Int?
        var time: String?
        var price: Int?
        var services: [ServicesListArray]?
    //    var services
        var city: String?
        var user: String?
        let user_avatar: String?
        let user_phone: String?
        var user_id: Int?
        var description: String?

}

struct ServicesListArray: Codable {
    var service_cat : String
    var service :     String
}


struct PostDetailModels: Codable {
    
    var token: String?
    var order: [PostData]?

}
