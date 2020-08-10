//
//  UCollectionViewSectionBackgroundLayout.swift
//  ProjectTest
//
//  Created by nor on 2020/8/10.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit

class UCollectionViewSectionBackgroundLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.register(<#T##nib: UINib?##UINib?#>, forDecorationViewOfKind: <#T##String#>)
    }
}
