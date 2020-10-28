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
