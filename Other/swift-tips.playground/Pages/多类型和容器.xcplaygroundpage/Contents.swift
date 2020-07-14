//: [Previous](@previous)

import Foundation
// 原生容器 Array, Dictionay, set

//let mixed: [CustomStringConvertible] = [1, "two", 3]
//
//for obj in mixed {
//    print(obj.description)
//}

enum IntOrString {
    case IntValue(Int)
    case StringValue(String)
}

let mixed = [IntOrString.IntValue(1),
             IntOrString.StringValue("two"),
             IntOrString.IntValue(3)]

for value in mixed {
    switch value {
    case let .IntValue(i):
        print(i * 2)
    case let .StringValue(s):
        print(s.capitalized)
    }
}

func sayHello1(str1: String = "Hello", str2: String, str3: String) {
    print(str1 + str2 + str3)
}

func sayHello2(str1: String = "Hello", str2: String, str3: String = "World") {
    print(str1 + str2 + str3)
}

sayHello1(str2:"12", str3: "34")

// 协议和类方法中的 Self

//: [Next](@next)
