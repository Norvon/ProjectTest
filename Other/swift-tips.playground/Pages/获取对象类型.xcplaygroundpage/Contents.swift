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
let str1 = "快乐的字符串"
let str2 = "快乐的字符串"
let str3 = "开心的字符串"

str1 == str2
str1 == str3

class TodoItem {
    let uuid: String
    var title: String
    
    init(uuid: String, title: String) {
        self.uuid = uuid
        self.title = title
    }
}

extension TodoItem: Equatable {
    
}

func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
    return lhs.uuid == rhs.uuid
}

// 对于 NSObject 子类的判等你有两种选择，要么重载 == ，要么重写 -isEqual:
// 原来 Objective-C 中使用 == 进行的对象指针的判定，在 Swift 中提供的是另一个操作符 === 。
// Swift 中对 NSObject 子类对象使用 == 时要是该子类没有实现这个操作符重 载的话将回滚到 -isEqual: 方法。
let num = 19
print(num.hashValue)

// 某些对象的哈希值 有可能随着系统环境或者时间的变化而改变。因此你也不应该依赖于哈希值来构建一些需要确定 对象唯一性的功能，在绝大部分情况下，你将会得到错误的结果。
//: [Next](@next)
