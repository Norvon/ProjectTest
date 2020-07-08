// 扩展
// 与Objective-C的分类不同的是，Swift的扩展没有名字
import Foundation

// Swift 中的扩展可以
// * 添加计算实例属性和计算类型属性
// * 定义实例方法和类方法
// * 提供新初始化器
// * 定义下标
// * 定义和使用新内嵌类型
// * 使现有的类型遵循某协议

// 在Swift中，你甚至可以扩展一个协议，以提供其要求的实现或添加符合类型的附加功能。

// 扩展的语法

//extension SomeType {
//
//}

//extension SomeType: SomeProtocol, AnotherProtocol {
//
//}

// 计算属性
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let ontInch = 25.4.mm
print("One inch is \(ontInch) meters")

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

// 初始化器
struct Size {
    var widht = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(widht: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.widht / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY),
                  size:size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(widht: 3.0, height: 3.0))

// 方法
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello!")
}

// 异变实例方法
extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()

// 下标
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

print(746381295[8])

// 内嵌类型
extension Int {
    enum Kind {
        case negative, zero, positive
    }

    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}


func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
