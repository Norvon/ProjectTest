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
typealias SortDescriptor<Root> = (Root, Root) -> Bool
let sortByYear: SortDescriptor<Person> = { $0.yearOfBirth < $1.yearOfBirth }
let sortByLastName: SortDescriptor<Person> = {
    $0.last.localizedStandardCompare($1.last) == .orderedAscending
}

func sortDescriptor<Root, Value> (
    key: @escaping (Root) -> Value,
    by areInIncreasingOrder: @escaping (Value, Value) -> Bool)
    -> SortDescriptor<Root> {
        return { areInIncreasingOrder(key($0), key($1)) }
}

let sortByYearAlt: SortDescriptor<Person> = sortDescriptor(key: {$0.yearOfBirth}, by: <)
people.sorted(by: sortByYearAlt)

func sortDescriptor<Root, Value>(
    key: @escaping (Root) -> Value,
    ascending: Bool = true,
    by comparator: @escaping (Value) -> (Value) -> ComparisonResult)
    -> SortDescriptor<Root> {
        return {
            lhs, rhs in
            let order: ComparisonResult = ascending
            ? .orderedAscending
            : .orderedDescending
            return comparator(key(lhs))(key(rhs)) == order
        }
}

let sortByFirstName: SortDescriptor<Person> = sortDescriptor(key: { $0.first }, by: String.localizedStandardCompare)
people.sorted(by: sortByFirstName)

func combine<Root>(sortesciptors: [SortDescriptor<Root>]) -> SortDescriptor<Root> {
    return {
        lhs, rhs in
        for areInIncreasingOrder in sortesciptors {
            if areInIncreasingOrder(lhs, rhs) { return true }
            if areInIncreasingOrder(rhs, lhs) { return false }
        }
        return false
    }
}

let combined: SortDescriptor<Person> = combine(sortesciptors: [sortByLastName, sortByFirstName, sortByYear])
people.sorted(by: combined)


// 合并两个排序函数
infix operator <||>: LogicalDisjunctionPrecedence
func <||><A>(lhs: @escaping (A, A) -> Bool,
             rhs: @escaping (A, A) -> Bool)
    -> (A, A) -> Bool {
        return {x, y in
            if lhs(x, y) { return true }
            if lhs(y, x) { return false }
            if rhs(x, y) { return true }
            return false
        }
}

// 从前往后判断
let combinedAlt = sortByFirstName <||> sortByLastName <||> sortByYear
people.sorted(by: combinedAlt)

func lift<A>(_ compare: @escaping(A) -> (A) -> ComparisonResult)
    -> (A?) -> (A?) -> ComparisonResult {
        return {lhs in
            { rhs in
                switch (lhs, rhs) {
                case (nil, nil): return .orderedSame
                case (nil, _): return .orderedAscending
                case (_, nil): return .orderedDescending
                case let (l?, r?): return compare(l)(r)
                }
            }
        }
}

let compare2 = lift(String.localizedStandardCompare)
temp = files.sorted(by: sortDescriptor(key: {$0.fileExtension}, by: compare2))
temp


// 函数作为代理
protocol AlertViewDelegate {
     mutating func buttonTapped(atIndex: Int)
}

class AlertView {
    var buttons: [String]
//    weak var delegate: AlertViewDelegate?
    var delegate: AlertViewDelegate?
    
    init(buttons: [String] = ["OK", "Cancel"]) {
        self.buttons = buttons
    }
    
    func fire() {
        delegate?.buttonTapped(atIndex: 1)
    }
}

class ViewController: AlertViewDelegate {
    let alert: AlertView
    
    init() {
        alert = AlertView()
        alert.delegate = self
    }
    
    func buttonTapped(atIndex index: Int) {
        print("Button tapped: \(index)")
    }
}

let vc = ViewController()
vc.alert.fire()

// 结构体上实现代理
// 我们将 buttonTapped(atIndex:) 标记为 mutating。这样，结构体就可以在方法被调用时改变自身的内 容了:

struct TapLogger: AlertViewDelegate {
    var taps:[Int] = []
    mutating func buttonTapped(atIndex index: Int) {
        taps.append(index)
    }
}

let alert = AlertView()
var logger = TapLogger()
alert.delegate = logger
alert.fire()
logger.taps
// 当我们给 alert.delegate 赋值的时候，Swift 将结构体进行了复制。所以，更新的并不是我们期 望中的 logger.taps，而是 alert.delegate.taps。
if let theLogger = alert.delegate as? TapLogger {
    print(theLogger.taps)
}

// ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️在代理和协议的模式中，并不适合使用结构体


// 使用函数，而非代理
class AlertView2 {
    var buttons: [String]
    var buttonTapped: ((_ buttonIndex: Int) -> ())?
    
    init(buttons:[String] = ["OK", "Cancel"]) {
        self.buttons = buttons
    }
    
    func fire() {
        buttonTapped?(1)
    }
}

struct TapLogger2 {
    var taps:[Int] = []
    mutating func logTap(index: Int) {
        taps.append(index)
    }
}

let alert2 = AlertView2()
var logger2 = TapLogger2()

// alert2.buttonTapped = logger2.logTap
alert2.buttonTapped = { logger2.logTap(index: $0) }
alert2.buttonTapped = { print("Button \($0) was tapped") }

// inout 参数和可变方法
// inout 做的事情是传值，然后复制回来，并不是传递引用。
// 一个 inout 参数持有一个传递给函数的值，函数可以改变这个值，然后从函数中传出并替换掉原来的值。
func increment(value: inout Int) {
    value += 1
}
var i = 0
increment(value: &i)
increment(value: &i)
increment(value: &i)
increment(value: &i)

var array = [0, 1, 2]
increment(value: &array[0])
array

struct Point {
    var x: Int
    var y: Int
}
var point = Point(x: 0, y: 0)
increment(value: &point.x)
point.x

// 如果一个属性是只读的（也就是说，只有 get 可用），我们将不能将其用于 inout 参数
extension Point {
    var squaredDistance: Int {
        return x*x + y*y
    }
}

// increment(value: &point.squaredDistance) // 错误

postfix func ++(x: inout Int) {
    x += 1
}

point.x++
print(point)

var dictionary = ["one": 1]
dictionary["one"]?++
dictionary["one"]

// 嵌套函数和 inout
func incrementTenTimes(value: inout Int) {
    func inc() {
        value += 1
    }
    for _ in 0..<10 {
        inc()
    }
}

var x = 0
incrementTenTimes(value: &x)
x

//func escapeIncrement(value: inout int) -> () -> () {
//    func inc() {
//        value += 1
//    }
//    //  error: 嵌套函数不能捕获 inout 参数然后让其逃逸
//    return inc
//}

// & 不意味 inout 的情况
// 你应该小心 & 的另一种含义：把一个函数参数转换为一个不安全的指针
func incref(pointer: UnsafeMutablePointer<Int>) -> () -> Int {
    return {
        pointer.pointee += 1
        return pointer.pointee
    }
}

let fun: () -> Int
do {
    var array = [0]
    fun = incref(pointer: &array)
}
fun()

// 属性

// 外部只读，内部读写 private(set) 或者 fileprivate(set)
import CoreLocation
struct GPSTrack {
    private(set) var record: [(CLLocation, Date)] = []
    
    var timesTampps: [Date] {
        return record.map { $0.1 }
    }
}

var gps = GPSTrack(record: [(CLLocation(), Date())])
(1, "qe").1

import UIKit
// 变更观察者
class SettingsController: UIViewController {
    @IBOutlet weak var label: UILabel? {
        didSet {
            label?.textColor = .black
        }
    }
}

// willSet 和 didSet 本质上是一对 属性的简写:一个是存储值的私有存储属性;另一个是读取值的公开计算属性，这个计算属性 的 setter 会在将值存储到私有存储属性之前和/或之后，进行额外的工作。

class Robot {
    enum State {
        case stopped, movingForward, turningRight, turningLeft
    }
    var state = State.stopped
}

class ObservableRobot: Robot {
    override var state: Robot.State {
        willSet {
            print("Transitioning from \(state) to \(newValue)")
        }
    }
}
var robot = ObservableRobot()
robot.state = .movingForward

// 延迟存储属性
class GPSTrackViewController: UIViewController {
    var track: GPSTrack = GPSTrack()
    
    lazy var preview: UIImage = {
        for point in track.record {
            
        }
        return UIImage()
    }()
}

// 和计算属性不同，存储属性和需要存储的延迟属性不能被定义在扩展中。
struct Point2 {
    var x: Double
    var y: Double
    private(set) lazy var distanceFromOrigin: Double = (x * x + y * y).squareRoot()
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

var point2 = Point2(x: 3, y: 4)
point2.distanceFromOrigin
point2.x += 10
point2.distanceFromOrigin // 不会发生改变

let immutablePoint = Point2(x: 3, y: 4)
// immutablePoint.distanceFromOrigin // 不能在一个不可变量上使用可变 getter
// lazy 关键字不会进行任何线程同步，如果在一个延迟属性完成计算之前，多个线程同时尝试访问它的话，计算有可能进行多次，计算过程中的各种副作用也会发生多次。

// 下标
let fibs = [0, 1, 1, 2, 3, 5]
let first = fibs[0]
fibs[1..<3]

// 自定义下标操作
extension Collection {
    subscript(indices indexList:Index...) -> [Element] {
        var result: [Element] = []
        for index in indexList {
            result.append(self[index])
        }
        return result
    }
}
// ... 三个点表示 indexList 是一个可变长度参数
Array("abcdefghijklmnopqrstuvwxyz")[indices:1, 3, 4]
//indices: 7, 4, 11, 11, 14

// 下标进阶
var japan: [String: Any] = [
    "name": "Japan",
    "capital": "Tokyo",
    "population": 126_740_000,
    "coordinates": [
        "latitude": 35.0,
        "longitude": 139.0
    ]
]

// 错误 类型 'Any' 没有下标成员
// japan["coordinate"]?["latitude"] = 36
japan

// 错误 不能对不可变表达式赋值
// (japan["coordinates"] as? [String: Double])?["coordinate"] = 36

extension Dictionary {
    subscript<Result>(key: Key, as type: Result.Type) -> Result? {
        get {
            return self[key] as? Result
        }
        set {
            guard let value = newValue else {
                self[key] = nil
                return
            }
            
            guard let value2 = value as? Value else {
                return
            }
            self[key] = value2
        }
    }
}

japan["coordinates", as: [String: Double].self]?["latitude"] = 36
japan["coordinates"]

// 键路径
struct SAddress {
    var street: String
    var city: String
    var zipCode: Int
}

struct SPerson {
    let name: String
    var address: SAddress
}

let streetKeyPath = \SPerson.address.street
print(streetKeyPath)
let nameKeyPath = \SPerson.name
print(nameKeyPath)

"Hello"[keyPath:\.count]

let simpsonResidence = SAddress(street: "1094 Evergreen Terrace", city: "Springfield", zipCode: 97475)
var lisa = SPerson(name: "Lisa Simpson", address: simpsonResidence)
lisa[keyPath: nameKeyPath]
lisa[keyPath: streetKeyPath] = "742 Evergreen Terrace"
//lisa[keyPath: nameKeyPath] = "12" // 因为name 定义的是不可变类型

var bart = SPerson(name: "Bart Simpson", address: simpsonResidence)
let Speople = [lisa, bart]
Speople[keyPath: \.[1].name]

// 可以通过函数建模的键路径
// KeyPath<Person, String> + KeyPath<String, Int> = KeyPath<Person, Int>

let nameCountKeyPath = nameKeyPath.appending(path: \.count)

func sortDescriptor2<Root, Value>(key: @escaping (Root) -> Value)
    -> SortDescriptor<Root> where Value: Comparable {
        return { key($0) < key($1) }
}

let streetSD: SortDescriptor<SPerson> = sortDescriptor2 {
    $0.address.street
}

func sortDescriptor3<Root, Value>(key: KeyPath<Root,Value>)
    -> SortDescriptor<Root> where Value: Comparable {
        return { $0[keyPath: key] < $1[keyPath: key] }
}

let streetSDKeyPath: SortDescriptor<SPerson> = sortDescriptor3(key: \.address.street)

// 可写键路径
do {
    let streetKeyPath = \SPerson.address.street
    let getStreet: (SPerson) -> String = {
        person in
        return person.address.street
    }
    let setStreet: (inout SPerson, String) -> () = {
        person, newValue in
        person.address.street = newValue
    }
    lisa[keyPath: streetKeyPath] = "1234Evergreen terrace"
    setStreet(&lisa, "1234 Evergreen Terrace" )
    
    
}

extension NSObjectProtocol where Self: NSObject {
    func observe<A, Other>(_ keyPath: KeyPath<Self, A>,
                           writeTo other: Other,
                           _ otherKeyPath: ReferenceWritableKeyPath<Other, A>)
        -> NSKeyValueObservation
        where A: Equatable, Other: NSObjectProtocol {
            return observe(keyPath, options: .new) { _, change in
                guard let newValue = change.newValue,
                    other[keyPath: otherKeyPath] != newValue else {
                        return
                }
                other[keyPath: otherKeyPath] = newValue
            }
    }
    
    func bind<A, Other>(_ keyPath: ReferenceWritableKeyPath<Self, A>,
                        to other: Other,
                        _ otherKeyPath: ReferenceWritableKeyPath<Other, A>)
        -> (NSKeyValueObservation, NSKeyValueObservation)
        where A: Equatable, Other: NSObject {
            let one = observe(keyPath, writeTo: other, otherKeyPath)
            let two = other.observe(otherKeyPath, writeTo: self, keyPath)
            return (one, two)
    }
}

do {
    final class Person: NSObject {
        @objc dynamic var name: String = ""
    }
    
    class TextFieeld: NSObject {
        @objc dynamic var text: String = ""
    }
    
    let person = Person()
    let textField = TextFieeld()
    let observatiion = person.bind(\.name, to: textField, \.text)
    person.name = "John"
    print("textField.text = \(textField.text)")
    
    textField.text = "Sarah"
    print("person.name =  \(person.name)")
}

// 键路径层级

// AnyKeyPath 和（Any）-> Any? 类型的函数相似。
// PartialKeyPath<Source> 和 (Source) -> Any? 函数相似。
// KeyPath<Source, Target> 和 (Source) -> Target 函数相似。
// WritableKeyPath<Source, Target> 和 (Source) -> Target 与 (inout Source, Target) -> () 这一对函数相似。
// ReferenceWritableKeyPath<Source, Target> 和 (Source) -> Target 与 (Source, Target) -> () 这一对函数相似。第二个函数可以用 Target 来更新 Source 的值，且要求 Source 是一个引用类型。 对 WritableKeyPath 和 ReferenceWritableKeyPath 进行区分是必要的， 前一个类型的 setter 要求它的参数是 inout 的。

// 自动闭包
func and (_ l: Bool, _ r: () -> Bool) -> Bool {
    guard l else { return false }
    return r()
}

let events = [1, 2, 3]
if and(!events.isEmpty, { events[0] > 10 }) {
    print("大于10")
}

func and(_ l: Bool, _ r: @autoclosure () -> Bool) -> Bool {
    guard l else { return false }
    return r()
}

if and(!events.isEmpty, events[0] < 10) {
    print("不存在或者小于10")
}

func log(ifFalse condition: Bool,
         message: @autoclosure () -> (String),
         file: String = #file,
         function: String = #function,
         line: Int = #line) {
    guard !condition else { return }
    print("Assertion faile: \(message()),\(file):\(function)(line \(line)")
}

// @escaping 标注
func getSumOf(array: [Int], handler: ((Int) -> Void)) {
    var sum: Int = 0
    for value in array {
        sum += value
    }
    handler(sum)
}

// @nonescaping 闭包的生命周期
// 1. 在函数调用期间将闭包作为函数参数传递
// 2. 对功能进行一些其它工作
// 3. 函数运行闭包
// 4. 函数返回编译器
// ⚠️ 步骤4执行后，闭包将在内存中不存在

//func getSumOf(array: [Int], handler: ((Int) -> Void)) {
//    // 步骤 2
//    var sum: Int = 0
//    for value in array {
//        sum += value
//    }
//
//    // 步骤 3
//    handler(sum)
//}
//
//func doSomething() {
//    // 步骤 1
//    self.getSumOf(array: [16,756,442,6,23]) { [weak self](sum) in
//        // 步骤 4
//        print(sum)
//    }
//}

// @escaping 闭包的生命周期


//: [Next](@next)
