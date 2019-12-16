//
//  AppDelegate.swift
//  DYZB
//
//  Created by liuhangjun on 2019/12/11.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window : UIWindow! = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window.frame = UIScreen.main.bounds
//        let vc = HomeViewController()
//        window.rootViewController = UINavigationController.init(rootViewController: vc)
//        window.makeKeyAndVisible()
        
        
        let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "Root")
        window.rootViewController = vc;
        window.makeKeyAndVisible()
        
        UITabBar.appearance().tintColor = UIColor.orange

        return true
    }

   
}

