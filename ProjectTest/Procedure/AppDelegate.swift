//
//  AppDelegate.swift
//  ProjectTest
//
//  Created by nor on 2020/5/7.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var reachability: NetworkReachabilityManager? = {
       return NetworkReachabilityManager(host: "http://app.u17.com")
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        print("abc".hashValue)
        print("abc".hashValue)
        print("abc".hashValue)
        
        showRootVC()
        return true
    }

}

