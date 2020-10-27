//
//  AppDelegate.swift
//  MU17
//
//  Created by nor on 2020/10/22.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var orientation: UIInterfaceOrientationMask = .portrait
    
    lazy var reachability: NetworkReachabilityManager? = {
        return NetworkReachabilityManager(host: "http://app.u17.com")
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// 初始化键盘
        initIQKeyboard()
        
        /// 初始化网络
        initNetwork()
        
        /// 显示跟控制器
        showRootVC()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientation
    }
}

