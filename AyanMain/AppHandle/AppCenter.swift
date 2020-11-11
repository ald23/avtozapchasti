//
//  AppCenter.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/24/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
import Network
import LGSideMenuController


class AppCenter{
    
    //MARK: - Properties
    var window = UIWindow()
    static let shared = AppCenter()
    private var currentViewController = UIViewController()
    
    
    //MARK: - Start functions
    func createWindow(_ window: UIWindow) -> Void {
        self.window = window
    }
    
    func start() -> Void {
        makeKeyAndVisible()
        makeRootController()
    }
        
    private func makeKeyAndVisible() -> Void {
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }
    
    func setRootController(_ controller: UIViewController) -> Void {
        currentViewController = controller
        window.rootViewController = currentViewController
    }
     
    func makeRootController()  {
        if UserManager.shared.getCurrentUser() == nil {
            setRootController(LoginPageViewController().inNavigation())
        } else {
            setRootMainPageViewController()
        }
    }
    
    
    func setRootMainPageViewController(){
        setRootController(setupSlideMenuController(viewController: MainPageViewController().inNavigation() as! UINavigationController))
    }
    
    //MARK: - functions
    func addSubview(view: UIView) -> Void {
        window.addSubview(view)
    }
    private func setupSlideMenuController(viewController : UINavigationController) -> UIViewController {

        
        let sideMenuController = LGSideMenuController.init(rootViewController: viewController,
                                                           leftViewController: SlideMenuViewController(), rightViewController: nil)
        sideMenuController.leftViewWidth = 300.0//width/1.25;
        sideMenuController.leftView?.alpha = 1
        
        return sideMenuController
    }
}
