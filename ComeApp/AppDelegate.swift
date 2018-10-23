//
//  AppDelegate.swift
//  ComeApp
//
//  Created by kobi on 27/08/2017.
//  Copyright © 2017 Kobi Kanetti. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window?.backgroundColor = .white
        
        //application.statusBarStyle = .lightContent
        //UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.statusBarStyle = .lightContent
   
        FirebaseApp.configure()
        
        return true
    }
    

    


}

