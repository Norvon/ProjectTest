//
//  MoodyStack.swift
//  CoreData0
//
//  Created by nor on 2020/11/30.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit
import CoreData

func createMoodyContainer(completion: @escaping(NSPersistentContainer) -> ()) {
    let container = NSPersistentContainer(name: "Moody")
    container.loadPersistentStores { _, error in
        guard error == nil else {
            fatalError("Failed to laod store: \(error!)")
        }
        print("加载 Moody 成功")
        DispatchQueue.main.async {
            completion(container)
        }
    }
}
