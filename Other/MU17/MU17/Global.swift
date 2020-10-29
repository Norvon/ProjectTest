//
//  Global.swift
//  MU17
//
//  Created by nor on 2020/10/27.
//

import UIKit
import Alamofire
import Hue
import SnapKit
import Kingfisher
import MJRefresh
import MBProgressHUD
import HandyJSON
import LLCycleScrollView

extension UIColor {
    class var background: UIColor {
        return UIColor(red: 242, green: 242, blue: 242, alpha: 1)
    }
    
    class var theme: UIColor {
        return UIColor(red: 29, green: 221, blue: 43, alpha: 1)
    }
}

extension String {
    static let searchHistoryKey = "searchHistoryKey"
    static let sexTypeKey = "sexTypeKey"
}

extension NSNotification.Name {
    static let USexTypeDidChange = NSNotification.Name("USexTypeDidChange")
}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height


// MARK: - SnapKit
extension ConstraintView {
    var usnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}





// 系统相关
let kApplication = UIApplication.shared
let kApplicationDelegate = kApplication.delegate
let kAppWindow = kApplicationDelegate?.window
let kRootViewController = kAppWindow!!.rootViewController


let kDefaultWidth: CGFloat = 375.0
let kDefaultHeight: CGFloat = 667.0

let kFullScreenWidth:  CGFloat = UIScreen.main.bounds.size.width
let kFullScreenHeight: CGFloat = UIScreen.main.bounds.size.height

let kWidthScale: CGFloat = kFullScreenWidth / kDefaultWidth
let kHeightScale: CGFloat = kFullScreenHeight / kDefaultHeight

// safe
var safeAreaInsets: UIEdgeInsets {
    var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let appWindow = UIApplication.shared.delegate!.window
    if #available(iOS 11.0, *) {
        insets = appWindow!!.safeAreaInsets
    }
    return insets
}

let kStatusBarHeight: CGFloat = safeAreaInsets.top
let kNavBarHeight:    CGFloat = 44.0
let kTopHeight:       CGFloat = (kStatusBarHeight + kNavBarHeight)

let kTabBarHeight: CGFloat = 49
let kBottomHeight: CGFloat = (safeAreaInsets.bottom + kTabBarHeight)





