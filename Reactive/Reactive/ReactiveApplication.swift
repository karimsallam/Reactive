//
//  ReactiveApplication.swift
//  DatePlay
//
//  Created by Karim Sallam on 22/12/2016.
//  Copyright © 2016 Cesar Aldana. All rights reserved.
//

import UIKit
import ReactiveSwift

@objc public protocol ApplicationDelegate: UIApplicationDelegate {
    
    @objc optional func application(_ application: UIApplication, didFinishLoading window: UIWindow)
}

open class ReactiveApplication: UIResponder {
    
    public var window: UIWindow?
    
    // Would love to change this to let but how could you inject when using @UIApplicationMain?
    public var applicationDelegates: [ApplicationDelegate]?
    
    public let reactiveState = MutableProperty<ReactiveState>(.loading)
    
    deinit {
        debugPrint("\(NSStringFromClass(type(of: self))) deallocated")
    }
}

extension ReactiveApplication: UIApplicationDelegate {
    
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        
        // If the Application has a window it will be safe to work on the UI when the window's rootViewController becomes visible.
        if let window = window {
            let rootUserInterface = window.rootViewController as! ReactiveUserInterface
            rootUserInterface.viewState.producer.startWithSignal { observer, disposable in
                observer.observeValues { [weak self] viewState in
                    if viewState == .Visible {
                        self?.reactiveState.value = .ready
                        
                        self?.applicationDelegates?.forEach { ad in
                            ad.application?(application, didFinishLoading: window)
                        }
                        
                        disposable.dispose()
                    }
                }
            }
        } else {
            self.reactiveState.value = .ready
        }
        
        var canHandle = false
        applicationDelegates?.forEach { ad in
            if let result = ad.application?(application, didFinishLaunchingWithOptions: launchOptions) {
                canHandle = canHandle || result // Can handle if at least one application delegate can handle.
            }
        }
        return canHandle
    }
    
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
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        var canHandle = false
        applicationDelegates?.forEach { ad in
            if let result = ad.application?(app, open: url, options: options) {
                canHandle = canHandle || result // Can handle if at least one application delegate can handle.
            }
        }
        return canHandle
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
