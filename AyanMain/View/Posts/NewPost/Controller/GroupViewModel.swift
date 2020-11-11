//
//  GroupViewModel.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 9/11/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

protocol DefaultViewModelOutput {
    var error: Observable<String> { get }
    var loading: Observable<Bool> { get }
}

public final class Observable<Value> {
    
    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
    }
    
    private var observers = [Observer<Value>]()
    
    public var value: Value {
        didSet { notifyObservers() }
    }
    
    public init(_ value: Value) {
        self.value = value
    }
    
    public func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
        observerBlock(self.value)
    }
    
    public func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
    
    private func notifyObservers() {
        for observer in observers {
            DispatchQueue.main.async { observer.block(self.value) }
        }
    }
}



class CategoryViewModel {
    var categories : Observable<[AddingServicesCatListModel]> = Observable([])
    
    func getServicesList(id : Int) {
       
        var parameters = Parameters()
        parameters["service_id"] = id
        ParseManager.shared.getRequest(url: AppConstants.API.getServicesCat, parameters: parameters, success: { (result: [AddingServicesCatListModel]) in
            self.categories.value = result

        }) { (error) in
            
        }
    }
    
}
class GetOrderIdViewModel {
    var categories : Observable<[AddingServicesCatListModel]> = Observable([])
    
    func getServicesList(id : Int) {
       
        var parameters = Parameters()
        parameters["service_id"] = id
        ParseManager.shared.getRequest(url: AppConstants.API.getServicesCat, parameters: parameters, success: { (result: [AddingServicesCatListModel]) in
            self.categories.value = result

        }) { (error) in
            
        }
    }
    
}
