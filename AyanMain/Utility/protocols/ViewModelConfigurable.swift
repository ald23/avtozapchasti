//
//  ViewModelConfigurable.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 8/24/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

protocol ViewModelConfigurable {
    var errorMessage: String {get set}
    var parameters: Parameters {get set}
    func getParameters() -> Parameters?
    func isValid() -> Bool
}
