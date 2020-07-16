//: [Previous](@previous)

import Foundation

class MyClass {
    func method (number: Int) -> Int {
        return number + 1
    }
}

let f = MyClass.method
let object = MyClass()
let result = f(object)(1)

// 单例
class MyManager {

    let num = 3

    static let shared = MyManager()
    private init() {}
}

let a = MyManager.shared
a.num

// MARK: - 123
// TODO: 123
// FIXME: 13

// 值类型和引用类型

//: [Next](@next)

