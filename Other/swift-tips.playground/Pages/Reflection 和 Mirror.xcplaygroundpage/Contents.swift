//: [Previous](@previous)

import Foundation

struct Book {
    let naem: String
}

struct Person {
    let name: String
    let age: Int
    let books = [Book(naem: "一本书"), Book(naem: "两本书") ]
}

let xiaoMing = Person(name: "xiaoMing", age: 16)
let r = Mirror(reflecting: xiaoMing)
print("xiaoMing 是 \(r.displayStyle!)")
print("属性个数：\(r.children.count)")

for child in r.children {
    if let name = child.label {
        print("属性名：\(String(describing: name))", terminator: "，")
        print("值：\(child.value)")
    }
}
dump(xiaoMing)


func valueFrom(_ object: Any, key: String) -> Any? {
    let mirror = Mirror(reflecting: object)
    
    for child in mirror.children {
        let (targetKey, targetMirror) = (child.label, child.value)
        if key == targetKey {
            return targetMirror
        }
    }
    return nil
}

if let name = valueFrom(xiaoMing, key: "books") as? Array<Book> {
    print("通过 key 得到值: \(name)")
}

// 隐式解包 Optional
var aNil: String? = nil

var anotherNil: String?? = aNil
var literalNil: String?? = nil

print(anotherNil)
if anotherNil == nil {
    print("anotherNil = nil")
}

if literalNil == nil {
    print("literalNil = nil")
}

let a = [1, 2, 3].map { "\($0 * 2)" }
print(a)

let num: Int? = 3
//var result: Int?
//
//if let realNum = num {
//    result = realNum * 2
//} else {
//    result = nil
//}

let result = num.map { $0 * 2}

protocol A2 {
    func method1() -> String
}

extension A2 {
    func method1() -> String {
        return "hi"
    }

    func method2() -> String {
        return "hi"
    }

}

struct B2: A2 {
    func method1() -> String {
        return "hello"
    }

    func method2() -> String {
        return "hello"
    }
}

let b2 = B2()

b2.method1()
b2.method2()

let a2 = b2 as A2
a2.method1() // hello
a2.method2() // hi

// where 和 模式匹配
let num2: [Int?] = [48, 99, nil]
num2.forEach {
    if let score = $0, score > 60 {
        print("及格啦 ～\(score)")
    } else {
        print(":(")
    }
}


let sortableArr: [Int] = [3, 1, 2, 4, 5]
let unsortableArr: [Any?] = ["Hello", 4, nil]

sortableArr.sorted()
//unsortableArr.sorted()

// indirect 和嵌套 enum
class Node<T> {
    let value: T?
    let next: Node<T>?

    init(value: T?, next: Node<T>?) {
        self.value = value
        self.next = next
    }
}

let list = Node(value: 1,
                next: Node(value: 2,
                           next: Node(value: 3,
                                      next: Node(value: 4, next: nil))))

indirect enum LinkedList<Element: Comparable> {
    case empty
    case node(Element, LinkedList<Element>)
    
    func removing(_ element: Element) -> LinkedList<Element> {
        guard case let .node(value, next) = self else {
            return .empty
        }
        
        return value == element ? next : LinkedList.node(value, next.removing(element))
    }
}

let linkedList = LinkedList.node(1, .node(2, .node(3, .node(4, .empty))))

let result2 = linkedList.removing(2)
print(result2)

//: [Next](@next)
