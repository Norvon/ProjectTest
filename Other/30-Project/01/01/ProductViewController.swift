//
//  ProductViewController.swift
//  01
//
//  Created by nor on 2020/10/14.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit
import CoreImage

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
        
        let filter = CIFilter.init(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        let str = "https://m.orangecds.com/login"
        let strData = str.data(using: .utf8)
        filter?.setValue(strData, forKey: "inputMessage")
        if let outImage = filter?.outputImage {
            productImageView.image = UIImage(ciImage: outImage, scale: 0.5, orientation: .up)
        }
    }
}
