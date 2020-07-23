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
var settings = defaultSettings
let overriddenSettings: [String: Setting] = ["Name": .text("Overr Jan's iPhone")]
settings.merge(overriddenSettings, uniquingKeysWith: {$1})
settings

extension Sequence where Element: Hashable {
    var frequencies:[Element: Int] {
        let frequencyPairs = self.map{($0, 1)}
        return Dictionary(frequencyPairs, uniquingKeysWith: +)
    }
}




//: [Next](@next)









