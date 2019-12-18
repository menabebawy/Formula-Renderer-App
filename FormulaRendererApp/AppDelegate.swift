//
//  AppDelegate.swift
//  FormulaRendererApp
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var rendererCoordinator : RendererCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()
        
        rendererCoordinator = RendererCoordinator(navigationController: window?.rootViewController as! UINavigationController)
        rendererCoordinator?.start()
        
        window?.makeKeyAndVisible()
        return true
    }
    
}
