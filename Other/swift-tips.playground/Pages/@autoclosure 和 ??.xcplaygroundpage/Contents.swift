//: [Previous](@previous)

import Foundation

//func logIfTrue(_ predicate:() -> Bool) {
//    if predicate() {
//        print("True")
//    }
//}
//logIfTrue({return 2 > 1})
//logIfTrue({2 > 1})
//logIfTrue{2 > 1}
//

func logIfTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("True")
    }
}

logIfTrue(2 > 1)

// ?? 非 nil 返回左侧值， nil 返回右侧值
let level: Int?
var startLevel = 1

// level = nil
level = 8
var currentLevel = level ?? startLevel

// @autoclosure 只支持 () -> T 不支持带有输入参数的写法

//func ??<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T {
//    switch optional {
//    case .Some(let value):
//        return value
//    case .None:
//        return defaultValue()
//    }
//}

// @escaping
func doWork(block: () -> ()) {
    block()
}

doWork{
    print("work")
}

//func doWorkAsync(block: @escaping ()->()) {
//    DispathQueue.main.async {
//        block()
//    }
//}


//: [Next](@next)
