//
//  callNotificationModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 10/6/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

struct callNotification : Codable {
        var from: Int?
        var to: String?
        var id: Int?

}

struct getCallNotification : Codable {
    
    var data: [CallsDataParametersModel]
}


struct CallsDataParametersModel: Codable {
    var from_id: Int?
    var from_name: String?

    var to: Int?
    var id: Int?

}

//struct userReviewModel: Codable {
//    var count:  Int?
//    var pages:  Int?
//    var offset: Int?
//    var limit:  Int?
//    var page:   Int?
//    var data: [ReviewDataParametersModel]
//}

