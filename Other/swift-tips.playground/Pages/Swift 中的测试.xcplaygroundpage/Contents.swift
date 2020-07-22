//: [Previous](@previous)

import Foundation
import CoreData


class MyModel: NSManagedObject {
    @NSManaged var title: String
}

extension Int {
    func times(f: (Int) -> ()) {
        print("Int")
        for i in 1...self {
            f(i)
        }
    }
    
    func times2(f: () -> Void) {
        print("Int")
        for _ in 1...self {
            f()
        }
    }
}

3.times { (i: Int) in
    print(i)
}


//: [Next](@next)
