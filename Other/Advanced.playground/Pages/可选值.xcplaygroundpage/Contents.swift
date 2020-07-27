//: [Previous](@previous)

import Foundation

// 通过枚举解决魔法数的问题
enum Optional1<Wrapped> {
    case none
    case some(Wrapped)
}

extension Collection where Element: Equatable {
    func tFirstIndex(of element: Element) -> Optional1<Index> {
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
let number = "1"
if var i = Int(number) {
    i += 1
    print(i)
}

let array2 = [1, 2, 3]
if !array2.isEmpty {
    print(array2[0])
}

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

    var fileExtension2: String? {
        guard let period = lastIndex(of: ".") else {
            return nil
        }

        let extensionStart = index(after: period)
        return String(self[extensionStart...])
    }
}

"hello.txt".fileExtension
"hello.txt".fileExtension2

func doStuff(withArray a: [Int]) {
    guard let firstElement = a.first else {
        return
    }
    firstElement
}

func unimplemented() -> Never {
    fatalError("This code path is not implemented yet.")
}

// 可选链
let str: String? = "Never say never"
let upper: String
if str != nil {
    upper = str!.uppercased()
} else {
    fatalError("no idea what to do now...")
}

let lower = str?.uppercased().lowercased()

extension Int {
    var half: Int? {
        guard self < -1 || self > 1 else {
            return nil
        }
        return self / 2
    }
}

print(20.half?.half?.half)

let dictOfArrays = ["nine":[0, 1, 2, 3]]
dictOfArrays["nine"]?[3]

let dictOfFunctions: [String: (Int, Int) -> Int] = [
    "add": (+),
    "subtract": (-)
]
dictOfFunctions["add"]
dictOfFunctions["add"]?(1, 1)
dictOfFunctions["subtract"]?(1, 1)

(==)(1, 2)
(+)(1, 2)
(-)(1, 2)
(*)(1, 2)
(/)(1, 2)

class TextField {
    private(set) var text = ""
    var didChange: ((String) -> ())?
    
    func textDidChange(newText: String) {
        text = newText
        didChange?(text)
    }
}

struct Person {
    var name: String
    var age: Int
}

var optionalLisa: Person? = Person(name: "Lisa Simpson", age: 8)
if optionalLisa != nil {
    optionalLisa!.age += 1
}

if var lisa = optionalLisa {
    lisa.age += 1
}

optionalLisa?.age += 1

var a: Int? = 5
a? = 10
a // Opthonal(10)

var b: Int? = nil
b? = 10
b

// b本身已经是 nil 给 b? 赋值不会生效

// nil 合并运算符
let stringteger = "1"
let number1 = Int(stringteger) ?? 0

let array3 = [1, 2, 3]
!array3.isEmpty ? array3[0] : 0

array3.first ?? 0
array3.count > 5 ? array[5] : "0"

extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}
array3[guarded: 5] ?? 0

let i1: Int? = nil
let j1: Int? = nil
let k1: Int? = 42
i1 ?? j1 ?? k1 ?? 0

// a ?? b ?? c 和 (a ?? b) ?? c
// a ?? b ?? c 是合并操作的链接
// (a ?? b) ?? c 是先解包括号内的内容，然后再处理外层
let s1: String?? = nil
(s1 ?? "inner") ?? "outer"
let s2: String?? = .some(nil) // Opthinal(nil) != nil
(s2 ?? "inner") ?? "outer"

// ?? 操作符 为短路求值

// 在字符串插值中使用可选值
let bodyTemperature: Double? = 37.0
let bloodGlucose: Double? = nil
print(bodyTemperature)
print("Blood glucose level: \(bloodGlucose)")

infix operator ???: NilCoalescingPrecedence

public func ???<T>(optaonal: T?, defaultValue: @autoclosure () -> String) -> String {
    switch optaonal {
    case let value?:
        return String(describing: value)
    case nil:
        return defaultValue()
    }
}

print("Body temperature: \(bodyTemperature ??? "n/a")")
print("Blood glucose level: \(bloodGlucose ??? "n/a")")

// 可选值 map
let characters: [Character] = ["a", "b", "c"]
String(characters[0])
var firstCharAsString: String? = nil
if let char = characters.first {
    firstCharAsString = String(char)
}

let firstChar = characters.map { (c) -> String in
    print(c)
    return String(c)
}

extension Optional {
    func map<U>(transform: (Wrapped) -> U) -> U? {
        guard let value = self else {
            return nil
        }
        return transform(value)
    }
}

extension Array {
    func reduce1(_ nextPartialResult: (Element, Element) -> Element) -> Element? {
        guard let fst = first else {
            return nil
        }
        
        return dropFirst().reduce(fst, nextPartialResult)
    }
    
    func reduce2(_ nextPartialResult: (Element, Element) -> Element) -> Element? {
        return first.map { (e) -> Element in
            dropFirst().reduce(e, nextPartialResult)
        }
    }
}

[1, 2, 3, 4].reduce1(+)
[1, 2, 3, 4].reduce2(+)

// 可选值 flatMap
let stringNumbers2 = ["1", "2", "3", "foo"]
let x = stringNumbers2.first.map { Int($0) }
let y = stringNumbers2.first.flatMap { Int($0) }

if let a = stringNumbers2.first, let b = Int(a) {
    print(b)
}

let urlString = "https://www.objc.io/log.png"
let view = URL(string: urlSting)
    .flatMap { try? Data(contentsOf: $0) }
    .flatMap { UIImage(data: $0) }
    .map {UIImageView(image: $0)}

if let view = view {
    // ...
}

extension Optional {
    func flatMap<U>(transform: (Wrapped) -> U?) -> U? {
        if let value = self, let transformed = transform(value) {
            return transformed
        }
        return nil
    }
}

// 使用 compactMap 过滤 nil
let numbers3 = ["1", "2", "3", "foo"]
var sum = 0
for case let i? in numbers3.map({ Int($0)}) {
    sum += i
}

let n = numbers3.compactMap{ Int($0) }.reduce(0, +)
n

extension Sequence {
    func compactMap<B>(_ transform: (Element) -> B?) -> [B] {
        return lazy
            .map(transform)
            .filter{ $0 != nil}
            .map{ $0! }
    }
}

// 可选值判等
let regex = "^Hello$"
if regex.first == "^" {
    print("匹配开头")
}

extension Optional: Equatable where Wrapped: Equatable {
    static func == (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
        switch(lhs, rhs) {
        case (nil, nil):
            return true
        case let (x?, y?):
            return x == y
            case (_?, nil),
                 (nil, _?):
            return false
        }
    }
}


var dictWithNils: [String: Int?] = [
    "one": 1,
    "two": 2,
    "none": nil
]

// dictWithNils["two"] = nil // 当前操作会移除 "tow": 2
 dictWithNils

// dictWithNils["two"] = Optional(nil) // 会移除 "tow": 2
// dictWithNils

// dictWithNils["two"] = .some(nil)
// dictWithNils

dictWithNils["two"]? = nil // 存在 key
dictWithNils

dictWithNils["three"]? = nil // 不存在的 key，没有值会被更新或者插入
dictWithNils

// 强制解包的时机
// 当你确定你的某个值不可能是 nil 时可以使用❗️，当应当会希望如果它意外是 nil 的话，程序应当直接挂掉。
// 每当你发现需要使用！时，可以火腿卡看是不是真的别无他法了。

let ages = [
    "Tim": 53, "Angela": 54, "Craig": 44,
    "Jony": 47, "Chris": 37, "Michael": 34
]

print(ages.keys
    .filter{ name in ages[name]! < 50 }
    .sorted())

print(ages.filter { (_, age) in age < 50 })
print(ages.filter { (_, age) in age < 50 }
    .map{ (name, _) in name }
    .sorted())

// 改进强制解包的错误信息
infix operator !!
func !!<T>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
    if let x = wrapped{ return x }
    fatalError(failureText())
}

//let s = "foo"
//let i = Int(s) !! "Expection integer, got\"\(s)\""

infix operator !?
func !?<T: ExpressibleByIntegerLiteral>
    (wrapped: T?, failureText: @autoclosure () -> String) -> T {
    assert(wrapped != nil, failureText())
    return wrapped ?? 0
}

let s = "20"
let i = Int(s) !? "Expection integer, got\"\(s)\""

func !?<T: ExpressibleByArrayLiteral>
    (wrapped: T?, failureText: @autoclosure () -> String) -> T {
    assert(wrapped != nil, failureText())
    return wrapped ?? []
}

func !?<T: ExpressibleByStringLiteral>
    (wrapped: T?, failureText: @autoclosure () -> String) -> T {
    assert(wrapped != nil, failureText())
    return wrapped ?? ""
}

func !?<T>(wrapped: T?,
           nilDefault: @autoclosure () -> (value: T, text: String)) -> T {
    assert(wrapped != nil, nilDefault().text)
    return wrapped ?? nilDefault().value
}

func !?(wrapped: ()?, failureText: @autoclosure() -> String) {
    assert(wrapped != nil, failureText())
}

// var output: String? = nil
// output?.write("something") !? "Wasn't expecting chained nil here"

// 想要挂起一个操作我们有三种方式。
// 首先，fatalError 将接受一条信息，并且无条件的停止操作
// 第二种选择，使用 assert 来检查条件，当条件结果为 false 时，停止执行并输出信息。在发版时，assert会被移除掉，也就是说条件不会被检测，操作也永远不会挂起。
// 第三种方式是使用 preconditiion, 它和 assert 有一样的接口，但是在发版中不会被移除，也就是说，只要条件被判定为 false，执行就会被停止。


// 隐式解包可选值


//:[Next](@next)
