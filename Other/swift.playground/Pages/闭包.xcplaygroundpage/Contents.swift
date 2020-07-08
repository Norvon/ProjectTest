//: [Previous](@previous)

import Foundation

let names = ["Chris", "Alex", "Ewa", "Ea", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2;
}

var reversedNames = names.sorted(by: backward)
reversedNames = names.sorted(by: {s1, s2 in s1 > s2})

reversedNames = names.sorted(by:  >)

print(reversedNames)
// 尾随闭包

print(names.sorted{ $0 > $1})

let digitNmaes = [
    0: "Zero",
    1: "One",
    2: "Two",
    
    3: "Three",
    4: "Four",
    5: "Five",
    
    6: "Six",
    7: "Seven",
    8: "Eight",
    
    9: "Nine",
]

let numbers = [16, 58, 510]
// map(_:)方法仅仅只有一个形式参数
let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNmaes[number % 10]! + output
        number /= 10
    } while number > 0
    
    return output
}

print(strings)


// 捕获值
// 一个闭包能够从上下文捕获已被定义的常量和变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍能够在其函数体内引用和修改这些值。

func makeIncrementer(forIncrement amount:Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()

incrementByTen()
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()

// 逃逸闭包 必须用 self
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100}
        someFunctionWithNonescapingClosure { x = 200}
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

// 自动闭包
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)

print("Now serving \(customerProvider())!")
print(customersInLine.count)
print(customerProvider)
