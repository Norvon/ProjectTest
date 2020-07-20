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

// 类簇
class Drinking {
    typealias LiquidColor = UIColor
    var color: LiquidColor {
        return .clear
    }

    class func dringking(name: String) -> Drinking {
        var drinking: Drinking
        switch name {
        case "Coke":
            drinking = Coke()
        case "Beer":
            drinking = Beer()
        default:
            drinking = Drinking()
        }
        return drinking
    }
}

class Coke: Drinking {
    override var color: LiquidColor {
        return .black
    }
}

class Beer: Drinking {
    override var color: LiquidColor {
        return .yellow
    }
}

let coke = Drinking.dringking(name: "Coke")
coke.color

let beer = Drinking.dringking(name: "Beer")
beer.color

let cokeClass = NSStringFromClass(type(of: coke))
let beerClass = NSStringFromClass(type(of: beer))

// 调用 C 动态库
// 通过 OC 的桥接进行调用

extension Double {
    func format(_ f: String) -> String {
        print(f)
        print(self)
        return String(format: "%\(f)f", self)
    }
}


let b = 1.234567
let f = ".2"
print("double:\(b.format(f))")

1 << 0
1 << 1
1 << 2
1 << 3
7 << 20

//UIView.animate(withDuration: 0.3,
//               delay: 0.0,
//               options: [.curveEaseIn, .allowUserInteraction],
//               animations: {},
//               completion: nil)
//
//struct YourOption: OptionSet {
//    let rawValue: UInt
//    static let none = YourOption(rawValue: 0)
//    static let option1 = YourOption(rawValue: 1 << 0)
//    static let option2 = YourOption(rawValue: 1 << 1)
//    static let option3 = YourOption(rawValue: 1 << 2)
//    // ...
//}

// 数组 enumerate
//let arr: NSArray = [1, 2, 3, 4, 5]
//var result = 0
//arr.enumerateObjects { (num, idx, stop) in
//    result += num as! Int
//    if idx == 2 {
//        stop.pointee = true
//    }
//}
//
//print(result)

var result = 0
for (idx, num) in [1, 2, 3, 4, 5].enumerated() {
    result += num
    if idx == 2 {
        break
    }
}
print(result)

// 类型编码 @encode
let int: Int = 0
let float: Float = 0.0
let double: Double = 0.0

let intNumber = int as NSNumber
let floatNumber = float as NSNumber
let doubleNumber = double as NSNumber

String(validatingUTF8: intNumber.objCType)
String(validatingUTF8: floatNumber.objCType)
String(validatingUTF8: doubleNumber.objCType)

// C 代码调用和 @asmname
sin(M_PI_2)

// 需要实现文件
//@asmname("test") func c_test(a: Int32) -> Int32
//
//func testSwift(input: Int32) {
//    let result = c_test(a: input)
//    print(result)
//}
//
//testSwift(input: 1)

// delegate
protocol MyClassDelegate {
    func method()
}

class MyClassD {
//    weak var delegate: MyClassDelegate?
    var delegate: MyClassDelegate?
}

class ViewController: UIViewController, MyClassDelegate {
    var someInstance: MyClassD!

    override func viewDidLoad() {
        super.viewDidLoad()

        someInstance = MyClassD()
        someInstance.delegate = self
    }

    func method() {
        print("Do something")
    }
}


// 添加属性
class MyClas {

}

private var key: Void?


extension MyClas {
    var title: String? {
        get {
            return objc_getAssociatedObject(self, &key) as? String
        }

        set {
            objc_setAssociatedObject(self,
                                     &key,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

func printTitle(_ input: MyClas) {
    if let title = input.title {
        print("Title: \(title)")
    } else {
        print("没有设置")
    }
}

let a = MyClas()
printTitle(a)
a.title = "Swifter.tips"
printTitle(a)

// Lock
func myMethod(anObj: AnyObject) {
    objc_sync_enter(anObj)
    // 在 enter 和 exit 之间持有 anObj 锁

    objc_sync_exit(anObj)
}

func synchronized(_ lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

func myMethodLocked(anObj: AnyObject) {
    synchronized(anObj) {
        // 在括号内持有 anObj 锁
    }
}

class Obj {
    var _str = "123"
    var str: String {
        get {
            return _str
        }
        set {
            synchronized(self) {
                _str = newValue
            }
        }
    }
}

import AudioToolbox
let fileURL = NSURL(string: "SomeURL")
var theSoundID: SystemSoundID = 0
AudioServicesCreateSystemSoundID(fileURL!, &theSoundID)

//: [Next](@next)

