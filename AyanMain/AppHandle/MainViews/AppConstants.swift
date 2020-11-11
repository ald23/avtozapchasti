//
//  AppConstants.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
class AppConstants {
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    static let navBarHeight = UINavigationController().navigationBar.bounds.height

    static let totalNavBarHeight = navBarHeight + statusBarHeight
    static func getTabbarHeight(_ tabBarController: UITabBarController?) -> CGFloat {
        return (tabBarController?.tabBar.frame.size.height)!
    }

    
    class API {
        static let baseUrl = "http://37.46.133.192:8093/api/v1/"
        
        
        static let login = "profile/login"
        static let register = "profile/register"
        static let editProfile = "profile/edit"
        static let getById = "profile/get_by_id"
        static let createOrder = "order/create"
        static let getBrand = "brand/get"
        static let getModelByBrand = "brand_model/get"
        static let getCities = "city/get"
        static let getServices = "service/get"
        static let getServicesCat = "service_cat/get"
        static let getByUser = "order/get_by_user_id"
        static let createReview = "review/create"
        static let getReviewsList = "review/get_by_user"
        static let getReviewsListById = "review/get_by_user_id"
        static let deletePost = "order/delete"
        static let getByOrderID = "order/get_by_order_id"
        static let getListFilter = "order/list"
        static let callUser = "notification/save_call"
        static let getCallUser = "notification/get_call"
//        static let getById = "profile/get_by_id"
//        static let getById = "profile/get_by_id"

    }

}
