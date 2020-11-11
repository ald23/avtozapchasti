//
//  GeneralResponse.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 8/24/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

class GeneralResponse<T: Codable>: Codable {
    let response: T
}
