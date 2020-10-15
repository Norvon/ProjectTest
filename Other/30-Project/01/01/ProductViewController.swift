//
//  ProductViewController.swift
//  01
//
//  Created by nor on 2020/10/14.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productNameLabel.text = product?.name
        if let imageName = product?.fullscreenImageName {
            productImageView.image = UIImage(named: imageName)
        }
    }
    
    @IBAction func addToCartButtonDidTap(_ sender: UIButton) {
        print("Add to cart successfully")
    }
    
}
