//: [Previous](@previous)

import Foundation

// 值类型和引用类型
// 结构体是值类型，而类是引用类型。
// 将一个结构体赋值给另外一个变量，会创建一个该结构体 的拷贝


// 其实修改一个结构体的属性这件事，在语义上是等同于 对变量赋值一个新的结构体实例。
import UIKit
var rect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
rect.origin.x = 10 // 等同于下一行代码
rect = CGRect(origin: CGPoint(x: 10, y: rect.origin.x), size: rect.size)

class ScoreClass {
    let home: Int
    let guest: Int
    init(home: Int, guest: Int) {
        self.home = home
        self.guest = guest
    }
}

struct ScoreStruct {
    let home: Int
    var guest: Int
}

var scoreClass = ScoreClass(home: 0, guest: 0)
var scoreStruct = ScoreStruct(home: 0, guest: 0)
// scoreClass.home += 1 // let
// scoreStruct.guest += 1 // let

scoreClass = ScoreClass(home: 2, guest: 1)
scoreStruct = ScoreStruct(home: 2, guest: 1)

// 类型为类的变量的值，是一个只想实例的引用；而类型为可钩体的变量的值，是结构体实例本身。
// 修改一个结构体的属性，即使修改的是多层的嵌套属性，都等同于给变量赋值一个全新的结构体实例。
// 结构体内部的属性尽量用 var 声明

// 可变方法
// 结构体 func 是不能修改结构体的任何属性
// mutating func 关注来创建一个可变方法
extension ScoreStruct {
    mutating func scoreGuest() {
        self.guest += 1
    }
}

var scoreStruct2 = ScoreStruct(home: 0, guest: 0)
scoreStruct2.scoreGuest()
scoreStruct2.guest

var x = [1, 2, 3]
var y = x
x.append(5)

// 实现写时复制
struct HTTPRequest {
    fileprivate class Storage {
        var path: String
        var headers: [String: String]
        init(path: String, headers: [String: String]) {
            self.path = path
            self.headers = headers
        }
    }
    
    private var storage: Storage
    init(path: String, headers: [String: String]) {
        storage = Storage(path: path, headers: headers)
    }
}

extension HTTPRequest {

    private var storageForWriting: HTTPRequest.Storage {
        mutating get {
            if !isKnownUniquelyReferenced(&storage) {
                self.storage = storage.copy()
            }
            return storage
        }
    }

    var path: String {
        get {
            return storage.path
        }
        set {
//            storage = storage.copy()
            storageForWriting.path = newValue
        }
    }
    
    var headers: [String: String] {
        get {
            return storage.headers
        }
        set {
//            storage = storage.copy()
            storage.headers = newValue
        }
    }
}

extension HTTPRequest.Storage {
    func copy() -> HTTPRequest.Storage {
        // ...
        return HTTPRequest.Storage(path: path, headers: headers)
    }
}

let req1 = HTTPRequest(path: "/home", headers: [:])
var req2 = req1
req2.path = "/users"
assert(req1.path == "/home")

var req = HTTPRequest(path: "/home", headers: [:])
for x in 0..<5 {
    req.headers["X-RequestId"] = "\(x)"
}

// isKnownUniquelyReferenced 函数可以检查一个引用类型的实力是否只有一个所有者
// 你必须保证传入的变量不会被另外一个线程所访问，这个限制不单单只是针对 isKnownUniquelyReferenced，它适用于所有的 inout 参数。
// isKnownUniquelyReferenced 不能防止竞争条件
// unowned 引用和弱引用并不被计算在内。即使我们不能把此类变量作为参数传入这个函数，否则函数总是会返回 false
// 不能作用于 Objective-C, 解决（可以把 Objective-C 类的实例封装在一个 Swift 类中）。

do {
    var req = HTTPRequest(path: "/home", headers: [:])
    var copy = req
    for x in 0..<5 {
        req.headers["X-RequestId"] = "\(x)"
    }
}



//: [Next](@next)
