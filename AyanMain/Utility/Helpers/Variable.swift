//
//  Variable.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 8/24/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

    //    MARK: - ObjectType

public enum ObjectType: String {
    case string = "String"
    case int = "Int"
    case bool = "Bool"
}

class Variable<T> {

    //    MARK: - Properties

    typealias E = T

    var objectType: ObjectType
    private var textField: UITextField?
    private var textView: UITextView?
    private var switchControl: UISwitch?
    private var callBack: ((Any?) -> ())?

    var value: E? {
        didSet {
            updateFields()
        }
    }

    //    MARK: - Initialization

    init(_ value: E? = nil) {
        self.objectType = ObjectType(rawValue: "\(T.self)")!
        self.value = value
    }

    //    MARK: - Simple functions

    func bind(field: UITextField) -> Void {
        self.textField = field
    }

    func bind(field: UITextView) -> Void {
        self.textView = field
    }

    func bind(field: UISwitch) -> Void {
        self.switchControl = field
    }

    func bind(callBack: @escaping (Any?) -> ()) -> Void {
        self.callBack = callBack
    }

    private func updateFields() -> Void {
        if let callBack = callBack {
            callBack(value)
        }
        else if let string = value as? String {
            textField?.text = string
            textView?.text = string
        } else if let bool = value as? Bool {
            switchControl?.isOn = bool
        }
    }
}
