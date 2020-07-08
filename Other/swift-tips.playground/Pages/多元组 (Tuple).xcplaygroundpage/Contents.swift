//: [Previous](@previous)

import Foundation
import UIKit

func swapMe1<T>(a: inout T, b: inout T) {
    let temp = a
    a = b
    b = temp
}

func swapMe2<T>(a: inout T, b: inout T) {
    (a,b) = (b, a)
}

var a = 3
var b = 4
swapMe1(a: &a, b: &b)
print(a)
print(b)

let rect: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100)
let (small, large) = rect.divided(atDistance: 20, from: .maxXEdge)
small
large


//: [Next](@next)
