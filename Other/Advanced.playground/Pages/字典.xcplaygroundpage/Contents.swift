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
// 那么可以通过设置环境变量 SWIFT_DETERMINISTIC_HASHING=1 来禁用随机种子， 但是你不应该在正式环境中这么做。

"abc".hashValue
"abc".hashValue
"abc".hashValue
"abc".hashValue

// Set
// 无序，元素只会出现一次，必须满足 Hashable
let naturals: Set = [1, 2, 3, 2]
naturals
naturals.contains(3)
naturals.contains(0)

// form 开头直接改变调用者，非 form 开头返回一个新的 Set
// 补
let iPods: Set = ["iPod touch", "iPod nano", "iPod mini", "iPod shuffle", "iPod Classic"]
let discontinuedIPods: Set = ["iPod mini", "iPod Classic", "iPod nano", "iPod shuffle"]
let currentlPods = iPods.subtracting(discontinuedIPods)
let test = ["iPod touch", "iPod nano", "iPod mini", "iPod shuffle", "123"]
iPods.subtracting(test)

let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
let neighbors = ["Bethany", "Eric", "Forlani", "Greta"]
employees.subtracting(neighbors)

// 交
let touchscreen: Set = ["iPhone", "iPad", "iPod touch", "iPod nano"]
let iPodsWithTouch = iPods.intersection(touchscreen)

// 并
var discontinued: Set = ["iBook", "Powerbook", "Power Mac"]
//discontinued.formUnion(discontinuedIPods)
discontinued.union(discontinuedIPods)
discontinued
discontinuedIPods

// 索引集合和字符集合
// var testIndexset: IndexSet = [1, 2, 3, 4, 11, 12, 14] // 存储 三个范围
var indices = IndexSet()
indices.insert(integersIn: 1..<5)
indices.insert(integersIn: 11..<15)
let evenIndices = indices.filter{ $0 % 2 == 0}

// CharacterSet 是一个高效的存储 Unicode 编码点 (code point) 的集合

// 在闭包中使用集合

//: [Next](@next)









