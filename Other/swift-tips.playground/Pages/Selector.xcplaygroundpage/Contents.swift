//: [Previous](@previous)

import Foundation

class MyClass {
    func method (number: Int) -> Int {
        return number + 1
    }
}

let f = MyClass.method
let object = MyClass()
let result = f(object)(1)

// 单例
class MyManager {

    let num = 3

    static let shared = MyManager()
    private init() {}
}

let aMyManager = MyManager.shared
aMyManager.num

// MARK: - 123
// TODO: 123
// FIXME: 13

// 值类型和引用类型
// 值类型减少了内存的分配和回收
func test(_ arr: [Int]) {
    for i in arr {
        print(i)
    }
}

var a = [1, 2, 3]
var b = a
// b.append(4)
String(format: "%p", a)
String(format: "%p", b)
withUnsafePointer(to: &a) {ptr in print(ptr)}
withUnsafePointer(to: &b) {ptr in print(ptr)}

class MyObbject {
    var nium = 0
}

var myObject = MyObbject()
var aObj = [myObject]
var bObj = aObj

String(format: "%p", aObj)
String(format: "%p", bObj)

let levels = "ABCDE"
for i in levels {
//    print(type(of: "\(i)"))
    print(i, terminator: "")
}

if (levels as String).contains("BC") {
    print("包含字符串")
}

let nsRange = NSMakeRange(1, 4)
// levels.replacingCharacters(in: nsRange, with: "AAAA")

let indexPositionOne = levels.index(levels.startIndex, offsetBy: 1)
let swiftRange = indexPositionOne ..< levels.index(levels.startIndex, offsetBy: 5)
levels.replacingCharacters(in: swiftRange, with: "AAAA")

// UnsafePointer

//void method(const int *num) {
//    print("%d", *num);
//}

func mentod(_ num: UnsafePointer<CInt>) {
    print(num.pointee)
}

var ca: CInt = 12
mentod(&ca)

let arr = NSArray(object: "meow")
let srt = unsafeBitCast(CFArrayGetValueAtIndex(arr, 0), to: CFString.self)

class MyClass2 {
    var a = 1
    deinit {
        print("deinit")
    }
}

var pointer: UnsafeMutablePointer<MyClass2>!

pointer = UnsafeMutablePointer<MyClass2>.allocate(capacity: 1)
pointer.initialize(to: MyClass2())

print(pointer.pointee.a)
pointer.deinitialize(count: 1)
pointer.deallocate()
pointer = nil

var x: UnsafeMutablePointer<tm>!
var t = time_t()
time(&t)
x = localtime(&t)
x = nil

// GCD 和延迟调用
let workingQueun = DispatchQueue(label: "my_queue")
workingQueun.async {
    print("努力工作")
    Thread.sleep(forTimeInterval: 2)

    DispatchQueue.main.async {
        print("结束工作，更新 UI")
    }
}

let tr: TimeInterval = 2.0
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + tr) {
    print("2 秒后输出")
}


typealias Task = (_ cancel: Bool) -> Void

func delay(_ time: TimeInterval, task: @escaping ()->()) -> Task? {
    func dispatch_later(block: @escaping ()->()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }

    var closure: (()->Void)? = task
    var result: Task?

    let delayedClosur: Task = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }

    result = delayedClosur

    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }

    return result
}

func cancel(_ task: Task?) {
    task?(true)
}

delay(2) {
    print("2 秒后输出")
}

let task = delay(5) {
    print("拨打 110")
}

cancel(task)



//: [Next](@next)

