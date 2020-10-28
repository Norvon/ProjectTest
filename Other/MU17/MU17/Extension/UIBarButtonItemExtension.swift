//
//  UIBarButtonItemExtension.swift
//  MU17
//
//  Created by nor on 2020/10/28.
//

import UIKit

extension UIBarButtonItem {
    convenience init(title: String?,
                     titleColor: UIColor = .white,
                     titleFount: UIFont = UIFont.systemFont(ofSize: 15),
                     titleEdgeInsets: UIEdgeInsets = .zero,
                     target: Any?,
                     action: Selector?) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = titleFount
        button.titleEdgeInsets = titleEdgeInsets
        if action != nil {
            button.addTarget(target, action: action!, for: .touchUpInside)
        }
        button.sizeToFit()
        if button.bounds.width < 40 || button.bounds.height > 40 {
            let width = 40 / button.bounds.height * button.bounds.width
            button.bounds = CGRect(x: 0, y: 0, width: width, height: 40)
        }
        self.init(customView: button)
    }
    
    convenience init(image: UIImage?,
                     selectImage: UIImage? = nil,
                     imageEdgeInsets: UIEdgeInsets = .zero,
                     target: Any?,
                     action: Selector?) {
        
        let btn = UIButton(type: .system)
        btn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.setImage(selectImage?.withRenderingMode(.alwaysOriginal), for: .selected)
        btn.imageEdgeInsets = imageEdgeInsets
        if action != nil {
            btn.addTarget(target, action: action!, for: .touchUpInside)
        }
        btn.sizeToFit()
        if btn.bounds.width < 40 || btn.bounds.height > 40 {
            let width = 40 / btn.bounds.height * btn.bounds.width
            btn.bounds = CGRect(x: 0, y: 0, width: width, height: 40)
        }
        self.init(customView: btn)
    }
}
