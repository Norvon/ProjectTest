//
//  NORBaseTabBarVC.swift
//  MU17
//
//  Created by nor on 2020/10/27.
//

import UIKit

class NORBaseTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTab()
    }
    
    func initTab() {
        tabBar.isTranslucent = false
        
        /// 首页
        let homeVC = NORHomeVC()
        addChildVC(homeVC,
                   title: "首页",
                   image: UIImage(named: "tab_home"),
                   selectedImage: UIImage(named: "tab_home_S"))
        
        /// 分类
        let cateVC = NORCateVC()
        addChildVC(cateVC,
                   title: "分类",
                   image: UIImage(named: "tab_class"),
                   selectedImage: UIImage(named: "tab_class_S"))
        
        /// 书架
        let bookVC = NORBookVC()
        addChildVC(bookVC,
                   title: "书架",
                   image: UIImage(named: "tab_book"),
                   selectedImage: UIImage(named: "tab_book_S"))
        
        /// 我的
        let mieVC = NORMineVC()
        addChildVC(mieVC,
                   title: "我的",
                   image: UIImage(named: "tab_mine"),
                   selectedImage: UIImage(named: "tab_mine_S"))
        
        
    }
    
    func addChildVC(_ childVC: UIViewController, title: String?, image: UIImage?, selectedImage: UIImage?) {
        childVC.title = title
        childVC.tabBarItem = UITabBarItem(title: nil,
                                          image: image?.withRenderingMode(.alwaysOriginal),
                                          selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        addChild(NORNavigationC(rootViewController: childVC))
    }
}


extension NORBaseTabBarVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else {
            return .lightContent
        }
        return select.preferredStatusBarStyle
    }
}
