//: [Previous](@previous)

import Foundation

// 数组
print("数组")

let fibs = [0, 1, 1, 2, 3, 5]
var mutalbleFibs = [0, 1, 1, 2, 3, 5]

mutalbleFibs.append(8)
mutalbleFibs.append(contentsOf: [13, 21])
print(mutalbleFibs)


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

// mutalbleFibs.popLast()
// mutalbleFibs.removeAll()
// mutalbleFibs.removeLast()

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
// sort()与sorted()的不同在于，sort是在原位重新排列列表，而sorted()是产生一个新的列表。
//
// sort 是应用在 list 上的方法，sorted 可以对所有可迭代的对象进行排序操作。
arr.sort(by: >)
arr
t = tArr.sorted{
    $0 > $1
}
t

let storeVersion = "3.14.10"
let currentVersion = "3.13.10"

extension String {
    func versionToInt() -> [Int] {
        return self.split(separator: ".").map {
            Int.init($0) ?? 0
        }
//        return self.components(separatedBy: ".").map {
//            Int.init($0) ?? 0
//        }
    }
}

currentVersion.versionToInt().lexicographicallyPrecedes(storeVersion.versionToInt())


var numbers = [30, 40, 20, 50, 0, 60, 10, 50]
let p = numbers.partition(by: { $0 > 30 })
let first = numbers[..<p]
let second = numbers[p...]


var someArray = [1, 2, 3]
let uhOh = someArray.withUnsafeBufferPointer {
    ptr in
    return ptr
}

// print(uhOh[10])

do {
    let arr = [5, 4, 3, 2, 1]
    arr.first
    arr.last
    arr.contains(128)
    arr.min()
    arr.max()

    let arr2 = [1, 2, 3, 4, 5]
    arr.elementsEqual(arr2)
    arr.elementsEqual(arr2.reversed())
    arr.starts(with: arr2)

    arr.starts(with: [5])

    arr.split(separator: 3)
    "hello hi".split(separator: "h")

    var t: Any
    arr.prefix(3)
    t = arr.prefix {
        $0 > 4
    }
    t

    t = arr.drop(while: { (item) -> Bool in
        return item > 1
    })
    t

    arr.reduce(into: 0) { (result, value) in
        result += value
    }
}

extension Array {

    func accumulate(_ transform: (Element?, Element) -> Element) -> [Element] {
        var result:[Element] = []
        result.reserveCapacity(count)
        for (i, item) in self.enumerated() {
            if (i == 0) {
                result.append(transform(nil, item))
            } else {
                result.append(transform(result.last, item))
            }
        }
        return result
    }
}

do {
//    let arr = [1, 2, 3, 4,  5, 6, 7]
    let arr = ["h", "e", "l"]
    var t: Any
    t = arr.accumulate { (one, two) -> String in
        if let value = one {
            return value + two
        } else {
            return two
        }
    }
    t
}

do {
    let array: [Int] = [1, 2, 2, 2, 3, 4, 4]
    var result:[[Int]] = array.isEmpty ? [] : [[array[0]]]
    for (previous, current) in zip(array, array.dropFirst()) {
        print("previous value = \(previous), current value = \(current)")
        if previous == current {
            print("result.endIndex = \(result.endIndex)")
            result[result.endIndex - 1].append(current)
        } else {
            result.append([current])
        }
    }

    result
}

extension Array {
    func split(where condition: (Element, Element) -> Bool) -> [[Element]] {
        var result:[[Element]] = self.isEmpty ? [] : [[self[0]]]
        for (previous, current) in zip(self, self.dropFirst()) {
            if condition(previous, current) {
                result.append([current])
            } else {
                result[result.endIndex - 1].append(current)
            }
        }
        return result
    }
}

do {
    let array = [1, 2, 2, 2, 3, 4, 4]
    let parts = array.split{ $0 != $1 }
    parts
    let parts2 = array.split(where: != )
}

extension Array {
    func accumulate<Result>(_ initialResult: Result,
                            _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map {
            next in
            print("running = \(running)", terminator: "  ")
            running = nextPartialResult(running, next)
            return running
        }
    }
    
    func myAccumulate(_ transform: (Element?, Element) -> Element) -> [Element] {
        var result:[Element] = []
        result.reserveCapacity(count)
        for (i, item) in self.enumerated() {
            if (i == 0) {
                result.append(transform(nil, item))
            } else {
                result.append(transform(result.last, item))
            }
        }
        return result
    }
    
    func tFilter(_ isIncluded: (Element) -> Bool) -> [Element] {
        var result:[Element] = []
        result.reserveCapacity(count)
        for item in self where isIncluded(item) {
            result.append(item)
        }
        return result
    }
    
    func tReduce<Result>(_ initialResult: Result,
                         _ nextPartialResult: (Result, Element) -> Result) -> Result {
        var result = initialResult
        for item in self {
            result = nextPartialResult(result, item)
        }
        return result
    }
    
    func map2<T>(_ transform: (Element) -> T) -> [T] {
        return reduce([], {
            $0 + [transform($1)]
        })
    }
    
    // meici
    func filter2(_ isIncluded: (Element) -> Bool) -> [Element] {
        return reduce([]) {
            print("$0 = \($0)", terminator: " ")
            print("$1 = \($1)", terminator: " ")
            print("[$1] = \([$1])", terminator: " ")
            print("$0 + [$1] = \($0 + [$1])")
            return isIncluded($1) ? ($0 + [$1]) : $0
        }
    }
    
    func filter3(_ isIncluded: (Element) -> Bool) -> [Element] {
        return reduce(into: []) { (result, element) in
            if isIncluded(element) {
                result.append(element)
            }
        }
    }
    
    func tFlatMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var result: [T] = []
        for item in self {
            result.append(contentsOf: transform(item))
        }
        return result
    }
}


do {
    print("可变和带有状态的闭包")
    
    var t: Any
    
    let array = [1, 2, 2, 2, 3, 4, 4]
    t = array.forEach { (item) in
//        print(item)
    }
    t
    
    t = [1, 2, 3, 4].accumulate(0) { $0 + $1}
    t
    
    t = (0..<10).map{$0 * $0}.filter{ $0 % 2 == 0 }
    t
    
    t = array.reduce("", { (result, item) -> String in
        return result + "\(item)"
    })
    t
    
    t = array.reduce("", {
        $0 + "\($1)"
    })
    t
    
    t = array.map2 {
        $0 * 2
    }
    t
    
    t = array.filter2{$0 > 2}
    t
    
    let suits = ["♠️", "♥️", "♣️", "♦️"]
    let ranks = ["J", "Q", "K", "A"]
    let result = suits.flatMap { (suit) in
        ranks.map { (rank) in
            (suit, rank)
        }
    }
    
    print(result)
    
    [1, 2, 3].forEach {
        print($0)
    }
}

// 一般来说，你只应该在需要所有结果时才去 选择使用 filter。
// map 和 filter 都作用在一个数组上，并产生另一个新的、经过修改的数组。

// for 和 forEach
// 在 forEach 中的 return 并不能让外部函数返回，它仅仅只是让闭包本身返回。
extension Array where Element: Equatable {
    func tTirstIndex(of element: Element) -> Int? {
        for idx in self.indices where self[idx] == element {
            return idx
        }
        return nil
    }
    
    // 错误用法
//    func firstIndex_foreach(of element: Element) -> Int? {
//        self.indices.filter { (idx) in
//            self[idx] == element
//        }.forEach { (idx) in
//            return idx
//        }
//        return nil
//    }
}

do {
    print("数组切片")
//    切片类型只是数组的一种表示方式，它背后的数据仍 然是原来的数组，只不过是用切片的方式来进行表示。因为数组的元素不会被复制，所以创建 一个切片的代价是很小的。
//    创建一个指针指向
    let fibs = [0, 1, 1, 2, 3, 5]
    let startIndex = 1
    let endIndex = fibs.count - 1
    var slice = fibs[startIndex...endIndex]
    slice
    type(of: slice)
//    slice[0] 会崩溃，应为 切片是从 1 开始的
    // slice[0]
    slice[2] = 100
//    Unmanaged.passUnretained(fibs as AnyObject).toOpaque()
    let newArray = Array(slice)
    type(of: newArray)
    fibs
}


//: [Next](@next)
