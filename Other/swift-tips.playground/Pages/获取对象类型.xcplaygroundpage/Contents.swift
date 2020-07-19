//: [Previous](@previous)

import Foundation

let date = NSDate()
let name: AnyClass! = object_getClass(date)
print(name!)

let name2 = type(of: date)
print(name2)

let string = "Hello"
let name3 = type(of: string)
print(name3)


class ClassA {}
class ClassB: ClassA{}

let obj: AnyObject = ClassB()

if (obj is ClassA) {
    print("属于 ClassA")
}

obj.isMember(of: ClassA.self) // false
obj.isMember(of: ClassB.self) // true

if (obj is ClassB) {
    print("属于 ClassB")
}

// KeyPath 和 KVO

class MyClass: NSObject {
    @objc dynamic var date = Date()
}

class AnotherClass: NSObject {
    var myOjbct: MyClass!
    var observation: NSKeyValueObservation?

    override init() {
        super.init()
        myOjbct = MyClass()
        print("初始化 AnotherClass, 当前日期：\(myOjbct.date)")

        observation = myOjbct.observe(\MyClass.date, options: [.new], changeHandler: { (_, change) in
            if let newDate = change.newValue {
                print("AnotherClass 日期发生变化 \(newDate)")
            }
        })

        let tr: TimeInterval = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + tr) {
            self.myOjbct.date = Date()
        }
    }
}

let anotherClass = AnotherClass()

// 局部 scope
func locak(_ closure: ()->()) {
    closure()
}

import UIKit

locak {
    let titleLabel = UILabel(frame: CGRect(x: 150, y: 30, width: 200, height: 40))

}

do {
    let titleLabel = UILabel(frame: CGRect(x: 150, y: 30, width: 200, height: 40))
}

let titleLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 150, y: 30, width: 200, height: 40))
    return label
}()

print("判等")

//: [Next](@next)
