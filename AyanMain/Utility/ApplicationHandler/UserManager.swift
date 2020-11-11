//
//  UserManager.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 8/24/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation
class UserManager {
    
    
    //  MARK: - properties
    static let shared = UserManager()
     let userDefaults = UserDefaults.standard
    
    
    //  MARK: - keys
    private let userIdentifier = "userIdentifier"
    private let isUserExecute = "userRole"
    private let userLang = "userLang"
    private init() {}
    
    
    //  MARK: - create session
    func createSession(withUser user: User) {
        let encoder = JSONEncoder()
        if let userData = try? encoder.encode(user) {
            userDefaults.set(userData, forKey: userIdentifier)
            userDefaults.synchronize()
        } else {
            print("can't save user session")
        }
    }
    func setAppLang(code: String) {
        userDefaults.set(code, forKey: userLang)
        userDefaults.synchronize()
    }
    func getCurrentLang() -> String {
        return userDefaults.string(forKey: userLang) ?? "ru"
    }
    func getCurrentUser() -> User? {
        let decoder = JSONDecoder()
        if let data = userDefaults.data(forKey: userIdentifier) {
            if let user = try? decoder.decode(User.self, from: data) {
                return user
            }
        }
        return nil
    }
        
    //  MARK: - isSession active
    func isSessionActive() -> Bool {
        return getCurrentUser() != nil
    }
    func deleteCurrentSession() {
        userDefaults.set(nil, forKey: isUserExecute)
        userDefaults.set(nil, forKey: userIdentifier)
        userDefaults.synchronize()
    }
    static func setUserType(type: String ){
        UserDefaults.standard.set(type, forKey: "userType")
    }
    static func getUsersType() -> String? {
        return UserDefaults.standard.string(forKey: "userType")
    }
    
    static func setFirebaseToken(token: String ){
        UserDefaults.standard.set(token, forKey: "firebaseToken")
    }
    static func getFirebaseToken() -> String? {
        return UserDefaults.standard.string(forKey: "firebaseToken")
    }
    
    
    
    //  MARK: - user type/role
    func setUserSeller(isExecute: Bool) -> Void {
        UserDefaults.standard.set(isExecute, forKey: isUserExecute)
        userDefaults.synchronize()
    }
    func isSeller() -> Bool {
        return UserDefaults.standard.bool(forKey: isUserExecute)
    }
}
