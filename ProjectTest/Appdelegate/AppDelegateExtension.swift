//
//  AppDelegate+Methods.swift
//  ProjectTest
//
//  Created by nor on 2020/5/7.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    func showRootVC(){
        let tabbarVC = BaseTabbarVC()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabbarVC
        self.window?.makeKeyAndVisible()
    }
}
