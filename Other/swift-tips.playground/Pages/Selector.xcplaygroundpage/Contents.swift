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

let aMyManager = MyManager.shared
aMyManager.num

// MARK: - 123
// TODO: 123
// FIXME: 13

// 值类型和引用类型
// 值类型减少了内存的分配和回收
func test(_ arr: [Int]) {
    for i in arr {
        print(i)
    }
}

var a = [1, 2, 3]
var b = a
// b.append(4)
String(format: "%p", a)
String(format: "%p", b)
withUnsafePointer(to: &a) {ptr in print(ptr)}
withUnsafePointer(to: &b) {ptr in print(ptr)}

class MyObbject {
    var nium = 0
}

var myObject = MyObbject()
var aObj = [myObject]
var bObj = aObj

String(format: "%p", aObj)
String(format: "%p", bObj)

let levels = "ABCDE"
for i in levels {
//    print(type(of: "\(i)"))
    print(i, terminator: "")
}

if (levels as String).contains("BC") {
    print("包含字符串")
}

let nsRange = NSMakeRange(1, 4)
// levels.replacingCharacters(in: nsRange, with: "AAAA")

let indexPositionOne = levels.index(levels.startIndex, offsetBy: 1)
let swiftRange = indexPositionOne ..< levels.index(levels.startIndex, offsetBy: 5)
levels.replacingCharacters(in: swiftRange, with: "AAAA")

// UnsafePointer

//: [Next](@next)

