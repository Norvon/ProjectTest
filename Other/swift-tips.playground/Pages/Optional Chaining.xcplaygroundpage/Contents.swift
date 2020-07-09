//: [Previous](@previous)

import Foundation


class Toy {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Pet {
    var toy: Toy?
}

class Child {
    var pet: Pet?
}


let xiaoming = Child()
let toyName = xiaoming.pet?.toy?.name

if let toyName = xiaoming.pet?.toy?.name {
    print(toyName)
}


extension Toy {
    func play() {
        
    }
}

xiaoming.pet?.toy?.play()


// 错误代码
// let playClosure = {(child: Child) -> () in child.pet?.toy?.play() }


 let playClosure = {(child: Child) -> ()? in child.pet?.toy?.play() }
// print(playClosure)

if let _: () = playClosure(xiaoming) {
    print("好开心～")
} else {
    print("没有玩具可以玩 :(")
}

// 操作符
// 重载
struct Vector2D {
    var x = 0.0
    var y = 0.0
}

func +(left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

let v1 = Vector2D(x: 2.0, y: 3.0)
let v2 = Vector2D(x: 1.0, y: 4.0)
let v3 = Vector2D(x: v1.x + v2.x, y: v1.y + v2.y)
let v4 = v1 + v2


// 重载不存在的操作符需要先进行声明
precedencegroup DotProductPrecedence {
    associativity: none
    higherThan: MultiplicationPrecedence
}

infix operator +* : DotProductPrecedence
func +* (left: Vector2D, right: Vector2D) -> Double {
    return left.x * right.x + left.y * right.y
}
let result1 = v1 +* v2
// # 在使用重载或者自定义操作符时，请先再三权衡斟酌，你或者你 的用户是否真的需要这个操作符。

// func 的参数修饰
func incrementor(variable: inout Int) {
    variable += 1
}

// 字面量表达
//: [Next](@next)
