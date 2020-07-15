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

//: [Next](@next)
