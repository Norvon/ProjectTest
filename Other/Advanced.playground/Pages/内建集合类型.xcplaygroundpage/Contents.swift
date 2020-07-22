//: [Previous](@previous)

import Foundation

var someArray = [1, 2, 3]
let uhOh = someArray.withUnsafeBufferPointer {
    ptr in
    return ptr
}

//print(uhOh[10])

//: [Next](@next)
