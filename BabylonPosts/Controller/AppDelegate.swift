//
//  AppDelegate.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 21/01/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
        return true
    }

}

