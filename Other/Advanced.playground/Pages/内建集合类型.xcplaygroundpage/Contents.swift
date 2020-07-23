//: [Previous](@previous)

import Foundation

var someArray = [1, 2, 3]
let uhOh = someArray.withUnsafeBufferPointer {
    ptr in
    return ptr
}

//print(uhOh[10])

// 数组
print("数组")

let fibs = [0, 1, 1, 2, 3, 5]
var mutalbleFibs = [0, 1, 1, 2, 3, 5]

mutalbleFibs.append(8)
mutalbleFibs.append(contentsOf: [13, 21])
print(mutalbleFibs)
//: [Next](@next)

let a = NSMutableArray(array: [1, 2, 3])
let b: NSArray = a
a.insert(4, at: 3)
a
b

let c = NSMutableArray(array: [1, 2, 3])
let d = c.copy() as! NSArray
c.insert(4, at: 3)
c
d

var arr = [1, 2, 3, 4, 5, 5]
for i in arr.dropFirst(3) {
    print(i)
}

for i in arr.dropLast(4) {
    print(i)
}

for (i, value) in arr.enumerated() {
    print("第 \(i) 个的值是\(value)")
}

var t: Any

t = arr.firstIndex {
    $0 == 5
}
t

t = arr.lastIndex {
    $0 == 5
}
t

t = arr.map {
    $0 * 2
}
t

t = arr.filter {
    $0 > 3
}
t

//mutalbleFibs.popLast()
//mutalbleFibs.removeAll()
//mutalbleFibs.removeLast()

extension Array {
    func myMap<T>(_ transform:(Element) -> T) -> [T] {
        var result: [T] = []
        result.reserveCapacity(count)
        for i in self {
            result.append(transform(i))
        }
        return result
    }
}
arr
// flatMap
t = arr.compactMap {
    $0 + 1
}
t

// 所有元素
t = arr.allSatisfy {
    $0 < 6
}

t = arr.allSatisfy {
    $0 > 0
}
t

var tArr = ["H", "e", "l", "l", "o"]
t = tArr.reduce(into: "", { (result, value) in
    result += value
})
t
//
//sort()与sorted()的不同在于，sort是在原位重新排列列表，而sorted()是产生一个新的列表。
//
//sort 是应用在 list 上的方法，sorted 可以对所有可迭代的对象进行排序操作。
arr.sort(by: >)
arr
t = tArr.sorted{
    $0 > $1
}
t

let storeVersion = "3.14.10"
let currentVersion = "3.130.10"

extension String {
    func versionToInt() -> [Int] {
        return self.components(separatedBy: ".").map {
            Int.init($0) ?? 0
        }
    }
}

currentVersion.versionToInt().lexicographicallyPrecedes(storeVersion.versionToInt())


var numbers = [30, 40, 20, 50, 0, 60, 10, 50]
let p = numbers.partition(by: { $0 > 30 })
let first = numbers[..<p]
let second = numbers[p...]

