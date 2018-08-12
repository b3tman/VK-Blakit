//
//  AppDelegate.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 02.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        VKSdk.initialize(withAppId: appID)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var initialViewController = storyboard.instantiateViewController(withIdentifier: loginControllerIdentifier)
        if UserDefaults.standard.bool(forKey: authorizedKey) {
            initialViewController = storyboard.instantiateViewController(withIdentifier: wallControllerIdentifier)
        }
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        VKSdk.processOpen(url as URL?, fromApplication: sourceApplication)
        
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}
