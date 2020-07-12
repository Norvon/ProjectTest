//: [Previous](@previous)

import Foundation

func appendQuery(url: String, key: String, value: AnyObject) -> String {

    func appendQuaryDictionary(url: String,
                               key: String,
                               value:[String: AnyObject]) -> String {
        return "result"
    }

    func appendQueryArray(url: String,
                          key: String,
                        value: [AnyObject]) -> String {
        //...
        return "result"
    }

    func appendQuerySingle(url: String,
                           key: String,
                           value: AnyObject) -> String {
        //...
        return "result"
    }

    if let dictionary = value as? [String: AnyObject] {
        return appendQuaryDictionary(url: url, key: key, value: dictionary)
    }
    else if let arrary = value as? [AnyObject] {
        return appendQueryArray(url: url, key: key, value: arrary)
    }
    else {
        return appendQuerySingle(url: url, key: key, value: value)
    }
}

// 命名空间
struct MyClassContainer1 {
    class MyClass {
        class func hello() {
            print("hello from MyClassContainer1")
        }
    }
}

struct MyClassContainer2 {
    class MyClass {
           class func hello() {
               print("hello from MyClassContainer2")
           }
       }
}

MyClassContainer1.MyClass.hello()
MyClassContainer2.MyClass.hello()

// typealias
protocol Cat {}
protocol Dog {}
typealias Pat = Cat & Dog

// associatedtype
protocol Food{}
protocol Animal {
    associatedtype F
    func eat(_ food: F)
}

struct Meat: Food {}
struct Grass: Food {}



struct Tiger: Animal {
    typealias F = Meat
    func eat(_ food: Meat) {
        print("eat \(food)")
    }
}

let meat = Meat()
Tiger().eat(meat)

// 可变参数类型
func sum(input: Int...) -> Int {
    return input.reduce(0, +)
}

print(sum(input: 1, 2, 3, 4, 5))

func myFunc(numbers: Int..., string: String) {
    numbers.forEach {
        for i in 0..<$0 {
            print("\(i + 1): \(string)")
        }
    }
}

myFunc(numbers: 1, 2, 3, string: "hello")

//: [Next](@next)
