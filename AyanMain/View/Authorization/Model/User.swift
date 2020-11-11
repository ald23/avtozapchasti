//
//  User.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 8/24/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - User
struct User: Codable {
        
    var token: String?
    var user: UserData?
}


struct UserData: Codable {
    let id:                 Int?
    let avatar:             String?
    let phone, name, type:  String
    let city_id:            String?
    let device_token:       String?
    let device_type:        String?

}

