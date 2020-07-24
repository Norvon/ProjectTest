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
var userSettings = defaultSettings
userSettings["Name"] = .text("Jared's iPhone")
userSettings["Do Not Disturb"] = .bool(true)
print(userSettings)

let oldName = userSettings.updateValue(.text("Jane's iPhone"), forKey: "Name")
userSettings["Name"]
oldName

// 一些有用的字典

// merge(_:uniquingKeysWith:) 字典进行合并的时候，有相同的 key 以某个字典的值为准
var settings = defaultSettings
let overriddenSettings: [String: Setting] = ["Name": .text("Overr Jan's iPhone")]
settings.merge(overriddenSettings, uniquingKeysWith: {$1})
settings

// Elemnt
extension Sequence where Element: Hashable {
    var frequencies:[Element: Int] {
        let frequencyPairs = self.map{($0, 1)}
        return Dictionary(frequencyPairs, uniquingKeysWith: +)
    }
}
let frequencies = "good".frequencies
print(frequencies.filter { $0.value > 1 })

let settingsAsStrings = settings.mapValues { setting -> String in
    switch setting {
    case .text(let text):
        return text
    case .int(let number):
        return String(number)
    case .bool(let value):
        return String(value)
    }
}

print(settingsAsStrings)

// Hashable 要求
// 对于结构体和枚举，只要它们是由可哈希的类型组成，那么 Swift 就可以帮我们自动合成 Hashable 协议所需要的实现。

//: [Next](@next)









