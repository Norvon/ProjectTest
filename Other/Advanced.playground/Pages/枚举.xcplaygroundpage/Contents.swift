//: [Previous](@previous)

import Foundation
enum TextAlignment {
    case left
    case center
    case right
}

@_frozen enum Optional<Wrapped> {
    case none
    case some(Wrapped)
}

enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

let alignment = TextAlignment.left
let download: Result<String, Error> = .success("<p>Hello world!</p>")

// 枚举是值类型
// * 枚举可以有方法，计算属性和下标操作。
// * 方法可以别生命为可变和不可变。
// * 你可以为枚举实现扩展。
// * 枚举可以实现各种协议。
// * 枚举不能拥有存储属性。

extension TextAlignment {
    init(defaultFor locale: Locale) {
        guard let language = locale.languageCode else {
            self = .left
            return
        }

        switch Locale.characterDirection(forLanguage: language) {
        case .rightToLeft:
            self = .right
        case .leftToRight,
             .topToBottom,
             .bottomToTop,
             .unknown:
            self = .left
        @unknown default:
            self = .left
        }
    }
}

let english = Locale(identifier: "en_AU")
TextAlignment(defaultFor: english)
let arabic = Locale(identifier: "ar_EG")
TextAlignment(defaultFor: arabic)

// 总和类型和乘积类型
// 一个元组（或者结构体，类）的居民数量，等于其成员的居民数量的乘积。因此，结构体，类和元组也被称为乘积类型
// 一个枚举的居民数量，等于它所成员的居民数量的总和，总和类型
enum PrimacyColor {
    case red
    case yellow
    case blue
}

enum ExtendedColor {
    case red
    case yellow
    case blue
    case gray(brightness: UInt8)
}

// 支持的模式类型
// * 通配符模式 _
// * 元组模式 ()
// * 枚举成员模式
// * 值绑定模式
// * 可选值模式
// * 类型转换模式
// * 表达式模式

// 在其它上下文中的模式匹配
// * 在赋值时结构元组 for(key, value) in dictionary {...}
// * 使用通配符来忽略我们不感兴趣的值 for(num, (key: k, value: v)) in dictionary.enumerated() {...}
// * 在一个 catch 子句中捕获错误 do {...} catch let error as NetworkError {...}
// * if case 和 guard case 语句 if case.gray(let brightness) = color {...}
// * for case 和 while case 循环
let (word, pi) = ("Hello", 3.1415)
for n in 1...10 where n.isMultiple(of: 3) {
    print(n)
}

// 使用枚举进行设计
// 1. Switch 语句的完备性
// 2. 不可能产生非法的状态
// 3. 使用枚举来实现状态
// 4. 在枚举和结构体之间做选择
// 5. 枚举和协议之间的相似之处
// 6. 使用枚举实现递归数据结构


// Switch 语句的完备性
// 分支必须覆盖所有可能的输入值

struct Message {
    var id: String
    var content: String?
}

struct StateStruct {
    var isLoading: Bool
    var messages: [Message]?
    var error: Error?
}

var structState = StateStruct(isLoading: true, messages: nil, error: nil)

enum StateEnum {
    case loading
    case loaded([Message])
    case failed(Error)
}

var enumState = StateEnum.loading
struct StateStruct2 {
    var messages: [Message]?
    var error: Error?
    
    var isLoading: Bool {
        get {
            return messages == nil && error == nil
        }
        set {
            messages = nil
            error = nil
        }
    }
}

typealias States2 = Result<[Message], Error>?

// 在枚举和结构体之间做选择

typealias LoginFailureReason = String

enum AnalyticsEvent {
    case loginFailed(reason: LoginFailureReason)
    case loginSucceeded
}

extension AnalyticsEvent {
    var name: String {
        switch self {
        case .loginSucceeded:
            return "loginSucceeded"
        case .loginFailed:
            return "loginFailed"
        }
        
    }
}


enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)
}
// indirect 告诉编译器吧 node 成员表示为一个引用

final class Box<A> {
    var unbox: A
    init(_ value: A) {
        self.unbox = value
    }
}

enum Boxedlist<Element> {
    case end
    case node(Element, next: Box<Boxedlist<Element>>)
}

let emptyList = List<Int>.end
let oneElementList = List.node(1, next: emptyList)
extension List {
    func cons(_ x: Element) -> List {
        return .node(x, next: self)
    }
}

let list = List<Int>.end.cons(1).cons(2).cons(3)
extension List: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end, { (partialList, element) -> List in
            partialList.cons(element)
        })
    }
}

let list2: List = [3, 2, 1]
switch list2 {
case .end:
    print("结束了")
case .node(let value, next: _):
    print(value)
}

extension List {
    mutating func push(_ x: Element) {
        self = self.cons(x)
    }
    
    mutating func pop() -> Element? {
        switch self {
        case .end:
            return nil
        case let .node(x, next: tail):
            self = tail
            return x
        }
    }
}

func pList(_ list: List<Int>) {
    switch list {
    case .end:
        print("end")
        return
    case let .node(value, next: tail):
        
        print("\(value)", terminator: "->")
        pList(tail)
    }
}

pList(list2)

var stack: List<Int> = [3, 2, 1]
var a = stack
var b = stack

a.pop()
print("a.pop()")
pList(a)

stack.pop()
pList(stack)

stack.push(4)
pList(stack)

b.pop()
pList(b)

b.pop()
pList(b)

stack.pop()
pList(stack)

stack.pop()
pList(stack)

// 原始值
enum HTTPStatus: Int {
    case ok = 200
    case created = 201
    case movedPermanently = 301
    case notFound = 404
}

//protocol RawRepresentable {
//    associatedtype RawValue
//    init?(rawValue: RawValue)
//    var rawValue: RawValue{ get }
//}
//
//HTTPStatus.init(rawValue:)
//HTTPStatus(rawValue: 404)
//HTTPStatus(rawValue: 1000)
//HTTPStatus.created.rawValue

// 手动实现 RawRepresentable
enum AnchorPoint {
    case center
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

extension AnchorPoint: RawRepresentable {
    typealias RawValue = (x: Int, y: Int)
    
    var rawValue: (x: Int, y: Int) {
        switch self {
        case .center: return (0, 0)
        case .topLeft: return (-1, 1)
        case .topRight: return (1, 1)
        case .bottomLeft: return (-1, -1)
        case .bottomRight: return (1, -1)
        }
    }
    
    init?(rawValue: (x: Int, y: Int)) {
        switch rawValue {
        case (0, 0): self = .center
        case (-1, 1): self = .topLeft
        case (1, 1): self = .topRight
        case (-1, -1): self = .bottomLeft
        case (1, -1): self = .bottomRight
        default: return nil
        }
    }
}

AnchorPoint.topRight.rawValue
AnchorPoint(rawValue: (x: 0, y: 0))
AnchorPoint(rawValue: (x: 2, y: 1))

enum Menultem: String, CaseIterable {
    case undo = "Undo"
    case cut = "Cut"
    case coopy = "Copy"
    case paste = "Paste"
}

// 计算 size
MemoryLayout<Menultem>.size
MemoryLayout<Message>.size

Menultem.allCases
Menultem.allCases.count
Menultem.allCases.map { print($0.rawValue)}


// 手动实现 Caselterable
extension Bool: CaseIterable {
    public static var allCases: [Bool] {
        return [false, true]
    }
}

Bool.allCases

extension UInt8: CaseIterable {
    public static var allCases: ClosedRange<UInt8> {
        return .min ... .max
    }
}

UInt8.allCases.count
UInt8.allCases.prefix(3) + UInt8.allCases.suffix(3)

// 固定和非固定枚举
// @frozen

// 尽量避免使用嵌套 switch 语句, 用元组匹配
// 利用明确初始化检查
// 避免用 none 或 some 来命名成员
// 对那些用保留的关键字来命名的成员使用反引号
// 可以像工厂方法一样使用成员
// 不要使用关联值来模拟存储属性，请该用结构体
// 不要过度使用关联值组件
// 把空枚举作为命名空间
enum Strategy {
    case custom
    case `default`
}
var strategy = Strategy.default

enum Strategy2 {
    case custom
    case `default`
}

// strategy = Strategy2.default



//: [Next](@next)
 
