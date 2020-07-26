//: [Previous](@previous)

import Foundation

// 通过枚举解决魔法数的问题
enum Optional<Wrapped> {
    case none
    case some(Wrapped)
}

extension Collection where Element: Equatable {
    func tFirstIndex(of element: Element) -> Optional<Index> {
        var idx = startIndex
        while idx != endIndex {
            if self[idx] == element {
                return .some(idx)
            }
            formIndex(after: &idx)
        }
        return .none
    }
}

var array = ["one", "two", "three"]
let idx = array.tFirstIndex(of: "four")
// 类型错误
// array.remove(at: idx)
switch array.firstIndex(of: "four") {
case .some(let idx):
    array.remove(at: idx)
case .none:
    break
}

switch array.firstIndex(of: "one") {
case let idx?:
    array.remove(at: idx)
case nil:
    print("什么都不做")
    break
}
array

// 可选值概览
array = ["one", "two", "three", "four"]
if let idx = array.firstIndex(of: "four") {
    array.remove(at: idx)
}

array = ["one", "two", "three", "four"]
if let idx = array.firstIndex(of: "four"), idx != array.startIndex {
    array.remove(at: idx)
}
array

import UIKit

let urlSting = "https://www.objc.io/logo.png"
if let url = URL(string: urlSting),
    let data = try? Data(contentsOf: url),
    let image = UIImage(data: data) {
    let view = UIImageView(image: image)
}

// while let 语句和 if let 非常相似，它表示当一个条件返回 nil 时便终止循环。
let arr = [1, 2, 3]
var iterator = arr.makeIterator()
while let i = iterator.next() {
    print(i, terminator: " ")
}

print()
for i in 0..<10 where i % 2 == 0 {
    print(i, terminator: " ")
}
arr

var iterator2 = (0..<10).makeIterator()
while let i = iterator2.next() {
    guard i % 2 == 0 else { continue }
    print(i)
}

// 双重可选值
let stringNumbers = ["1", "2", "three"]
let maybeInts = stringNumbers.map {Int($0)}
maybeInts.count

for maybeInt in maybeInts {
    print(maybeInt)
}

var itemrator = maybeInts.makeIterator()
while let maybeint = itemrator.next() {
    print(maybeint, terminator: " ")
}
print()

for case let i? in maybeInts {
    print(i, terminator: " ")
}
print()

for case nil in maybeInts {
    print("No value")
}

for case let .some(i) in maybeInts {
    print(i)
}

let j = 5
if case 0..<10 = j {
    print("\(j)")
}

// if var and while var 
//: [Next](@next)
