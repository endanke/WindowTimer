//
//  AppDelegate.swift
//  WindowTimer
//
//  Created by Daniel Eke on 20.5.2020.
//  Copyright © 2020 Daniel Eke. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: 2, to: Date())

        WindowTimer.targetDate = date
        
        return true
    }

}

