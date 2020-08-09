//
//  Global.swift
//  ProjectTest
//
//  Created by nor on 2020/5/11.
//  Copyright © 2020 nor. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import MJRefresh

extension UIColor {
    class var background: UIColor {
        return UIColor(r: 242, g: 242, b: 242)
    }

    class var theme: UIColor {
        return UIColor(r: 29, g: 221, b: 43)
    }
}

extension String {
    static let searchHistoryKey = "sexTypeKey"
    static let sexTypeKey = "sexTypeKey"
}

extension NSNotification.Name {
    static let USexTypeDidChange = NSNotification.Name("USexTypeDidChange")
}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

var isIphonx: Bool {
    return UI_USER_INTERFACE_IDIOM() == .phone
        && (max(screenHeight, screenWidth) == 812
            || max(screenHeight, screenWidth) == 896)
}

private func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

// MARK: print
func uLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):funciton:\(function):line:\(lineNumber)]- \(message)")
    #endif
}

// MARK: Kingfisher
extension KingfisherWrapper where Base: ImageView {
    @discardableResult
    public func setImage(urlString: String?,
                         placeholder: Placeholder? = UIImage(named: "normal_placeholder_h"))
        -> DownloadTask? {
            return setImage(with: URL(string: urlString ?? ""),
                            placeholder: placeholder,
                            options: [.transition(.fade(0.5))])
    }
}

extension KingfisherWrapper where Base: UIButton {
    @discardableResult
    public func setImage(urlString: String?,
                         for state: UIControl.State,
                         placeholder: UIImage? = UIImage(named: "normal_placeholder_h"))
        -> DownloadTask? {
            return setImage(with: URL(string: urlString ?? ""),
                            for: state,
                            placeholder: placeholder,
                            options: [.transition(.fade(0.5))])

    }
}

extension UICollectionView {
    func reloadData(animation: Bool = true) {
        if animation {
            reloadData()
        } else {
            UIView.performWithoutAnimation {
                reloadData()
            }
        }
    }
}
