//
//  UHomeViewController.swift
//  ProjectTest
//
//  Created by nor on 2020/8/10.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit

class UHomeViewController: UPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_search"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(selectAction))
    }
    
    @objc private func selectAction() {
        uLog("点击搜索")
    }
}
