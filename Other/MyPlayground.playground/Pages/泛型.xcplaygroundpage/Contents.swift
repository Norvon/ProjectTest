
import Foundation

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}

var someInt = 3
var another = 107
swapTwoInts(&someInt, &another)
print("someInt =  \(someInt)， another = \(another)")

func swapTwoValuts<T>(_ a: inout T, _ b: inout T) {
    let tempA = a
    a = b
    b = tempA
}


// 泛型类型
