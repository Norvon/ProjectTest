//: [Previous](@previous)

import Foundation

class Cat {
    var name: String
    init() {
        name = "cat"
    }
}

class Tiger: Cat {
    let power: Int
    override init() {
        power = 10
        super.init() // 视特定情况可以忽略，（不对父类进行修改）
        name = "tiger"
    }
}


// Designated, Convenience 和 Required
class ClassA {
    let numA: Int
   required init(num: Int) {
        numA = num
    }

    // 不能被资料重写，和从子类中通过 super 调用
    convenience init(bigNum: Bool) {
        self.init(num: bigNum ? 1000 : 1)
    }
}

class ClassB: ClassA {
    let numB: Int


//    override convenience init(bigNum: Bool) {
//        // Initializer does not override a designated initializer from its superclass
//    }

    required init(num: Int) {
        numB = num + 1
        super.init(num: num)
//        super.init(bigNum: true)
    }
}

let anObj = ClassB(bigNum: true)
print(anObj.numB)

// 初始化返回 nil
let url = NSURL(string: "ht tp://swifter。tips")
print(url ?? "")

extension Int {
    init?(fromString: String) {
        self = 0
        var digit = fromString.count - 1
        for c in fromString {
            var number = 0
            if let n = Int(String(c)) {
                number = n
            } else {
                switch c {
                case "一": number = 1
                case "二": number = 2
                case "三": number = 3
                case "四": number = 4
                case "五": number = 5
                case "六": number = 6
                case "七": number = 7
                case "八": number = 8
                case "九": number = 9
                case "零": number = 0
                default: return nil
                }
            }

            self = self + number * Int(pow(10, Double(digit)))
            digit = digit - 1
        }
    }
}

let num1 = Int(fromString: "七9八")
let num2 = Int(fromString: "理发家里的")

// static 和 class
struct Point {
    let x: Double
    let y: Double

    // 存储属性
    static let zer = Point(x: 0, y: 0)

    // 计算属性
    static var ones: [Point] {
        return [Point(x: 1, y: 1),
                Point(x: -1, y: 1),
                Point(x: 1, y: -1),
                Point(x: -1, y: -1)]
    }

    // 类型方法
    static func add(p1: Point, p2: Point) -> Point {
        return Point(x: p1.x + p2.x, y:p1.y + p2.y)
    }
}


// v1.2 以前
//class MyMangaer {
//    class var shared: MyMangaer {
//        struct Static {
//            static let sharedInstance: MyMangaer = MyMangaer()
//        }
//
//        return Static.sharedInstance
//    }
//}
//private let sharedInstance = MyManager()
//class MyManager {
//    class var shared: MyManager {
//        return sharedInstance
//    }
//}

// v1.2
class MyManager {
    static let shared = MyManager()
    private init() {}
}

protocol MyProtocol {
    static func foo() -> String
}

struct MyStruct: MyProtocol {
    static func foo() -> String {
        return "MyStruct"
    }
}

enum MyEnum: MyProtocol {
    static func foo() -> String {
        return "MyEnum"
    }
}

class MyClass: MyProtocol {
    // 在 class 中可以使用 class
    static func foo() -> String {
        return "MyClass.foo()"
    }

    // 也可以使用static
    static func bar() -> String {
        return "MyClass.bar()"
    }
}
//: [Next](@next)
