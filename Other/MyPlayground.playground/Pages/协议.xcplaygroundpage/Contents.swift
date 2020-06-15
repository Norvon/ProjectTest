// 协议
import Foundation

// 协议的语法
//protocol SomeProtocol {
//
//}

//struct SomeStructure: FirstProtocol, AnotherProtocol {
//
//}

//class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
//
//}

// 属性要求
// 协议可以要求所有遵循该协议的类型提供特定名字和类型的实例属性或类型属性。
// 协议并不会具体说明属性是存储型属性还是计算型属性 它只具体要求属性有特定的名称和类型
// 协议同时要求一个属性必须明确是可读的或可读和可写的。

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var dodsNotNeedToBeSettable: Int { get }
    static func someTypeMethod()
    init(someParamter: Int)
}

// 在协议中定义类型属性时在前面添加 static 关键字。当类的实现使用 class 或 static 关键字前缀声明类型属性要求时，这个规则仍然适用
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")
john.fullName

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullName

// 方法要求
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")

// 异变方法要求
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()


// 协议初始化器要求的类实现
//class SomeClass: SomeProtocol {
//    required init(someParamter: Int) {
//        <#code#>
//    }
//}
//如果一个子类重写了父类指定的初始化器，并且遵循协议实现了初始化器要求，那么就要为这个初始化器的实现添加 required 和 override 两个修饰符：

// 可失败初始化器要求

// 将协议作为类型
class Dice {
    let sides: Int
    let geneerator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.geneerator = generator
    }

    func roll() -> Int {
        return Int(geneerator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice rool is \(d6.roll())")
}

// 委托
