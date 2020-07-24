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
//: [Next](@next)
