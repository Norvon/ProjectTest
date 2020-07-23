//: [Previous](@previous)

import Foundation

enum Setting {
    case text(String)
    case int(Int)
    case bool(Bool)
}

let defaultSettings: [String: Setting] = [
    "Airplane Mode": .bool(false),
    "Name": .text("My iPhone")
]

defaultSettings["Name"]
defaultSettings["name"]

// 可变性

//: [Next](@next)
