//
//  BaseNavVC.swift
//  ProjectTest
//
//  Created by nor on 2020/5/9.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit


enum BaseNavBarStyle {
    case theme
    case clear
    case white
}

class BaseNavVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let interactionGes = interactivePopGestureRecognizer else {
            return
        }
        
        guard let targetView = interactionGes.view else {
            return
        }
        
        guard let internalTargets = interactionGes.value(forKeyPath: "targets") as? [NSObject] else {
            return
        }
        
        guard let internalTarget = internalTargets.first?.value(forKeyPath: "target") else {
            return
        }
    
        let action = Selector(("handleNavigationTransition:"))
        let fullScreenGesture = UIPanGestureRecognizer(target: internalTarget, action: action)
        fullScreenGesture.delegate = self
        targetView.addGestureRecognizer(fullScreenGesture)
        interactionGes.isEnabled = false
        
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 { // 隐藏 tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let topVC = topViewController else { return .lightContent }
        return topVC.preferredStatusBarStyle
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension BaseNavVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let isLeftToRight = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
        guard let ges = gestureRecognizer as? UIPanGestureRecognizer else {
            return true
        }
        
        var tempRatio: CGFloat = -1
        if (isLeftToRight) {
            tempRatio = 1
        }
        
        if ges.translation(in: gestureRecognizer.view).x * tempRatio <= 0
        || disablePopGesture {
            return false
        }
        
        return viewControllers.count != 1;
    }
}

// MARK: - extension UINavigationController
extension UINavigationController {
    private struct AssociatedKeys {
        static var disablePopGesture: Void?
    }
    
    var disablePopGesture: Bool {
        get {
            guard let temp = objc_getAssociatedObject(self, &AssociatedKeys.disablePopGesture) as? Bool else {
                return false
            }
            
            return temp
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.disablePopGesture, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func barStyle(_ style: BaseNavBarStyle) {
        switch style {
        case .theme:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(named: "nav_bg"), for: .default)
            navigationBar.shadowImage = UIImage()
        case .clear:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .white:
            navigationBar.barStyle = .default
            navigationBar.setBackgroundImage(UIColor.white.image(), for: .default)
            navigationBar.shadowImage = nil
        }
    }
}


