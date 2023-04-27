//
//  AppDelegate.swift
//  MVVM-C
//
//  Created by Dong on 2023/4/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
        
        return true
    }
}
