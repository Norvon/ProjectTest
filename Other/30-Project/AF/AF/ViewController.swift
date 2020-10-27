//
//  ViewController.swift
//  AF
//
//  Created by nor on 2020/10/15.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func clickBtn(_ sender: Any) {
        print("点击")
        let d = AF.request("https://httpbin.org/get")
        URLConvertible().ur
        AF.request(URLConvertible,
                   method: .get,
                   parameters: nil, encoder: <#T##ParameterEncoder#>, headers: <#T##HTTPHeaders?#>, interceptor: <#T##RequestInterceptor?#>, requestModifier: <#T##Session.RequestModifier?##Session.RequestModifier?##(inout URLRequest) throws -> Void#>)
        
    }
}

