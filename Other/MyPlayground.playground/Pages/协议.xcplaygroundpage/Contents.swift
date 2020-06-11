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

