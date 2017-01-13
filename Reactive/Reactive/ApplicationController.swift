//
//  ApplicationController.swift
//  DatePlay
//
//  Created by Karim Sallam on 22/12/2016.
//  Copyright © 2016 Cesar Aldana. All rights reserved.
//

import UIKit

open class ApplicationController: UIResponder {
    
    let applicationDelegates: [UIApplicationDelegate]?
    
    public init(application: UIApplication, launchOptions: [AnyHashable : Any]?, applicationDelegates: [UIApplicationDelegate]?) {
        self.applicationDelegates = applicationDelegates
    }
}

extension ApplicationController: UIApplicationDelegate {
        
    open func applicationDidBecomeActive(_ application: UIApplication) {
        applicationDelegates?.forEach { ad in
            ad.applicationDidBecomeActive?(application)
        }
    }
    
    open func applicationWillEnterForeground(_ application: UIApplication) {
        applicationDelegates?.forEach { ad in
            ad.applicationWillEnterForeground?(application)
        }
    }
    
    open func applicationDidEnterBackground(_ application: UIApplication) {
        applicationDelegates?.forEach { ad in
            ad.applicationDidEnterBackground?(application)
        }
    }
    
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        applicationDelegates?.forEach { ad in
            ad.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }
    
    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        applicationDelegates?.forEach { ad in
            ad.application?(application, didFailToRegisterForRemoteNotificationsWithError: error)
        }
    }
    
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        applicationDelegates?.forEach { ad in
            ad.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
        }
    }
    
    open func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        applicationDelegates?.forEach { ad in
            ad.application?(application, didReceive: notification)
        }
    }
    
    open func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        applicationDelegates?.forEach { ad in
            ad.application?(application, didRegister: notificationSettings)
        }
    }
}
