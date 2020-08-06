//
//  AppDelegate.swift
//  Recordings-MVC
//
//  Created by Norvon on 2020/8/4.
//  Copyright © 2020 Norvon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let splitViewController = window!.rootViewController as! UISplitViewController
        splitViewController.delegate = self
        splitViewController.preferredDisplayMode = .allVisible
        return true
    }

    func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
        return true
    }

    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    // MARK: - UISplitViewControllerDelegate
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
            guard let topAsDetailController = (secondaryViewController as? UINavigationController)?.topViewController as? PlayViewController else {
                return false
            }
            if topAsDetailController.recording == nil {
                return true
            }
            return false
    }
}

