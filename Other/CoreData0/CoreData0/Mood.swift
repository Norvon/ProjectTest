//
//  Mood.swift
//  CoreData0
//
//  Created by nor on 2020/11/30.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

final class Mood: NSManagedObject {
    @NSManaged fileprivate(set) var date: Date
    @NSManaged fileprivate(set) var colors: [UIColor]
    
    static func insert(into context: NSManagedObjectContext, image: UIImage) -> Mood {
        let mood: Mood = context.inser
    }
}

