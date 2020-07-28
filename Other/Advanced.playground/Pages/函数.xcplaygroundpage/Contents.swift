//: [Previous](@previous)

import Foundation
// 1. 函数可以像 Int 或者 String 那样被赋值给变量，也可i作为另一个函数的输入参数，或者另一个函数的返回值来使用。
// 2. 函数能够捕获存在与其局部作用域之外的变量
// 3. 有两种发发可以创建函数，一种是使用 func 关键字，另一种是{}。在 Swift 中，后一种被称为 闭包表达式。

func conunterFunc() -> (Int) -> String {
    var counter = 0
    func innerFunc(i: Int) -> String {
        counter += i
        return "Running total: \(counter)"
    }
    return innerFunc
}

let f = conunterFunc()
f(3) // 0 + 3
f(4) // 3 + 4

let g = conunterFunc()
g(2) // 0 + 2
g(2) // 2 + 2

f(2) // 7 + 2

func doubler(i: Int) -> Int {
    return i * 2
}

[1, 2, 3, 4].map(doubler)
let dobuleAlt = { (i: Int) -> Int in return i * 2}
[1, 2, 3, 4].map(dobuleAlt)

// 使用匿名函数的方法：你可以在定义一个表达式的同时，对它进行调用。这个方法贼定义那些初始化时代吗多余一行的属性时会很有用。
print([1, 2, 3].map{ $0 * 2 })

[1, 2, 3].map { (i: Int) -> Int in return i * 2}
[1, 2, 3].map({i in return i * 2})
[1, 2, 3].map({i in i * 2})
[1, 2, 3].map({$0 * 2})
[1, 2, 3].map(){$0 * 2}
[1, 2, 3].map{$0 * 2}

print((0..<3).map{_ in Int.random(in: 1..<100)})

let isEven = {$0 % 2 == 0}
isEven(2)
isEven(3)

let isEvenAlt = { (i: Int8) -> Bool in i % 2 == 0 }
let isEvenAlt2: (Int8) -> Bool = { $0 % 2 == 0 }
let isEvenAlt3 = { $0 % 2 == 0 } as (Int8) -> Bool

extension BinaryInteger {
    var isEvent: Bool{ return self % 2 == 0}
}

func isEvent<T: BinaryInteger>(_ i: T) -> Bool {
    return i % 2 == 0
}

// Cannot convert value of type '(Int) -> Bool' to specified type '(Int8) -> Bool'
// let int8isEven: (Int8) -> Bool = isEven

// 函数的灵活性
var myArray = [3, 1, 2]
myArray.sorted()
myArray.sorted(by: >)

var numberStrings = [(2, "two"), (1, "one"), (3, "three")]
numberStrings.sorted(by: <)

let animals = ["elephant", "zebra", "dog"]
print(animals.sorted { (lhs, rhs) -> Bool in
    let l = lhs.reversed()
    let r = rhs.reversed()
    return l.lexicographicallyPrecedes(r)
})


@objcMembers
final class Person: NSObject {
    let first: String
    let last: String
    let yearOfBirth: Int
    init(first: String, last: String, yearOfBirth: Int) {
        self.first = first
        self.last = last
        self.yearOfBirth = yearOfBirth
        // super.init() 在这里被隐式调用
    }
}
let people = [
    Person(first: "Emily", last: "Young", yearOfBirth: 2002),
    Person(first: "David", last: "Gray", yearOfBirth: 1991),
    Person(first: "Robert", last: "Barnes", yearOfBirth: 1985),
    Person(first: "Ava", last: "Barnes", yearOfBirth: 2000),
    Person(first: "Joanne", last: "Miller", yearOfBirth: 1994),
    Person(first: "Ava", last: "Barnes", yearOfBirth: 1998),
]

// 姓
let lastDescriptor = NSSortDescriptor(key: #keyPath(Person.last),
                                      ascending: true,
                                      selector: #selector(NSString.localizedStandardCompare(_:)))

// 名
let firstDescriptor = NSSortDescriptor(key: #keyPath(Person.first),
                                       ascending: true,
                                       selector: #selector(NSString.localizedStandardCompare(_:)))

// 出生年份
let yearDescriptor = NSSortDescriptor(key: #keyPath(Person.yearOfBirth),
                                      ascending: true)

let descriptors = [lastDescriptor, firstDescriptor, yearDescriptor]
(people as NSArray).sortedArray(using: descriptors)

var strings = ["Hello", "hallo", "Hallo", "hello"]
strings.sort {
    $0.localizedStandardCompare($1) == .orderedAscending
}
strings

people.sorted { $0.yearOfBirth < $1.yearOfBirth }

extension String {
    var fileExtension: String? {
        let period: String.Index
        if let idx = lastIndex(of: ".") {
            period = idx
        } else {
            return nil
        }
        let extensionStart = index(after: period)
        return String(self[extensionStart...])
    }
}

var files = ["one", "file.h", "file.c", "test.h"]
files.sort {
    l, r in r.fileExtension.flatMap {
        l.fileExtension?.localizedStandardCompare($0)
        } == .orderedAscending
}
files
people
var temp: Any? = nil
temp = people.sorted { p0, p1 in
    let left = [p0.last, p0.first]
    let right = [p1.last, p1.first]
    return left.lexicographicallyPrecedes(right) {
        $0.localizedStandardCompare($1) == .orderedAscending
    }
}
temp

// 函数作为数据


//: [Next](@next)
