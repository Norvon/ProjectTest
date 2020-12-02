//
//  ViewController.swift
//  CoreData0
//
//  Created by nor on 2020/11/30.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let request = NSFetchRequest<Mood>(entityName: "Mood")
        let sortDescriptor = NSSortDescriptor(key: "data", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.fetchBatchSize = 20
    }
}

