//
//  TestVC.swift
//  ProjectTest
//
//  Created by nor on 2020/5/9.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.random
    }
    
    func strLength(_ str: String?) -> Int {
        if let s = str {
            return s.count
        } else {
            return 0
        }
    }
    

}
