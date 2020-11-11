//
//  userReviewModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 9/23/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation
struct userReviewModel: Codable {
    var count:  Int?
    var pages:  Int?
    var offset: Int?
    var limit:  Int?
    var page:   Int?
    var data: [ReviewDataParametersModel]
}

struct ReviewDataParametersModel: Codable {
    var id:         Int?
    var user_id:    Int?
    var seller_id:  Int?
    var seller_name: String?
    var text:       String?
    
}
