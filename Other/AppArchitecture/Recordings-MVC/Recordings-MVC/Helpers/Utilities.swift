//
//  Utilities.swift
//  Recordings-MVC
//
//  Created by nor on 2020/8/4.
//  Copyright © 2020 Norvon. All rights reserved.
//

import Foundation
import UIKit


/// formatter
private let formatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = .pad
    formatter.allowedUnits = [.hour, .minute, .second]
    return formatter
}()


/// 转换 TimeInterval 为 String
/// - Parameter time: time TimeInterval
/// - Returns: TimeInterval String
func timeString(_ time: TimeInterval) -> String {
    return formatter.string(from: time)!
}

extension UIViewController {
    
    /// 弹窗
    /// - Parameters:
    ///   - title: 标题
    ///   - accept: 确认 默认 OK
    ///   - cancel: 取消  默认 Cancel
    ///   - placeholder: 输入框默认提示文案
    ///   - callback: callback
    func modalTextAlert(title: String,
                        accept: String = .ok,
                        cancel: String = .cancel,
                        placeholder: String,
                        callback: @escaping (String?) -> ()) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: {$0.placeholder = placeholder})
        alert.addAction(UIAlertAction(title: cancel, style: .cancel) { _ in
            callback(nil)
        })
        alert.addAction(UIAlertAction(title: accept, style: .default) { _ in
            callback(alert.textFields?.first?.text)
        })
        present(alert, animated: true)
    }
}

fileprivate extension String {
    static let ok = NSLocalizedString("OK", comment: "")
    static let cancel = NSLocalizedString("Cancel", comment: "")
}
