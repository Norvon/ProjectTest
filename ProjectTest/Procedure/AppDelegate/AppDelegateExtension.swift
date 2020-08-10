//
//  AppDelegate+Methods.swift
//  ProjectTest
//
//  Created by nor on 2020/5/7.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

extension AppDelegate {
    
    func showRootVC() {
        let tabbarVC = BaseTabbarVC()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabbarVC
        self.window?.makeKeyAndVisible()
    }
    
    func configBase() {
        // MARK: - 键盘
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        // MARK: - 性别缓存
        let defaults = UserDefaults.standard
        if defaults.value(forKey: String.sexTypeKey) == nil {
            defaults.set(1, forKey: String.sexTypeKey)
            defaults.synchronize()
        }
        
        // MARK: - 网络监控
        self.reachability?.startListening(onUpdatePerforming: { (status) in
            switch status {
            case .reachable(.cellular):
                UNoticeBar(config: UNoticeBarConfig(title: "主人,检测到您正在使用移动数据")).show(duration: 2)
            default: break
            }
        })
        
    }
    
}
