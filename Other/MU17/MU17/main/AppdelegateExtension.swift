//
//  AppdelegateExtension.swift
//  MU17
//
//  Created by nor on 2020/10/27.
//

import UIKit

extension AppDelegate {
    
    /// 初始化键盘 IQKeyboard
    func initIQKeyboard() {
        
    }
    
    /// 初始化网络
    func initNetwork() {
        
    }
    
    /// 显示跟控制器
    func showRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = NORBaseTabBarVC()
        window?.makeKeyAndVisible()
    }
    
    /// 强制转换屏幕
    class func changeOrientationTo(landscapeRight: Bool) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        if landscapeRight == true {
            delegate.orientation = .landscapeRight
            UIApplication.shared.supportedInterfaceOrientations(for: delegate.window)
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        } else {
            delegate.orientation = .portrait
            UIApplication.shared.supportedInterfaceOrientations(for: delegate.window)
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
    }
}
