//
//  AppDelegate.swift
//  AyanMain
//
//  Created by Bakdaulet Myrzakerov on 8/10/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit
import IQKeyboardManager
import Firebase
import FirebaseMessaging

@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        IQKeyboardManager.shared().isEnabled = true
//        AppCenter.shared.createWindow(window!)
//        AppCenter.shared.start()
//
//        return true
//    }
//
//}

class AppDelegate: UIResponder, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.applicationIconBadgeNumber = 0
            IQKeyboardManager.shared().isEnabled = true
        
            FirebaseApp.configure()
            Messaging.messaging().delegate = self
        
           
            registerForRemoteNotifications(application: application)
            window = UIWindow(frame: UIScreen.main.bounds)
            AppCenter.shared.createWindow(window!)
            AppCenter.shared.start()
        
        return true
    }
    var orientationLock = UIInterfaceOrientationMask.all
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }
    private func registerForRemoteNotifications(application: UIApplication) -> Void {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
    
    }
    
}
    
    



extension AppDelegate: MessagingDelegate, UNUserNotificationCenterDelegate {
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
{

    Messaging.messaging().apnsToken = deviceToken
   
    
}

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(" didFailToRegisterForRemoteNotificationsWithError  \(error)" )
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        UserManager.setFirebaseToken(token: fcmToken)
        
    }


func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
{
    completionHandler([.alert, .badge, .sound])
}

func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {

    if let info = userInfo[gcmMessageIDKey] {
        print(info)
    }

    print("userinfo no completionHandler", userInfo)
}

func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                 fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {


    
    if let info = userInfo[gcmMessageIDKey] {
          print(info)
      }

    
      print("userinfo no completionHandler", userInfo)
    
    
}
}
