//: [Previous](@previous)

import Foundation
// 1. 函数可以像 Int 或者 String 那样被赋值给变量，也可i作为另一个函数的输入参数，或者另一个函数的返回值来使用。
// 2. 函数能够捕获存在与其局部作用域之外的变量
// 3. 有两种发发可以创建函数，一种是使用 func 关键字，另一种是{}。在 Swift 中，后一种被称为 闭包表达式。

func conunterFunc() -> (Int) -> String {
    var counter = 0
    func innerFunc(i: Int) -> String {
        counter += i
        return "Running total: \(counter)"
    }
    return innerFunc
}

let f = conunterFunc()
f(3) // 0 + 3
f(4) // 3 + 4

let g = conunterFunc()
g(2) // 0 + 2
g(2) // 2 + 2

f(2) // 7 + 2

func doubler(i: Int) -> Int {
    return i * 2
}

[1, 2, 3, 4].map(doubler)
let dobuleAlt = { (i: Int) -> Int in return i * 2}
[1, 2, 3, 4].map(dobuleAlt)







//: [Next](@next)
