//: [Previous](@previous)

import Foundation
// 原生容器 Array, Dictionay, set

//let mixed: [CustomStringConvertible] = [1, "two", 3]
//
//for obj in mixed {
//    print(obj.description)
//}

enum IntOrString {
    case IntValue(Int)
    case StringValue(String)
}

let mixed = [IntOrString.IntValue(1),
             IntOrString.StringValue("two"),
             IntOrString.IntValue(3)]

for value in mixed {
    switch value {
    case let .IntValue(i):
        print(i * 2)
    case let .StringValue(s):
        print(s.capitalized)
    }
}

func sayHello1(str1: String = "Hello", str2: String, str3: String) {
    print(str1 + str2 + str3)
}

func sayHello2(str1: String = "Hello", str2: String, str3: String = "World") {
    print(str1 + str2 + str3)
}

sayHello1(str2:"12", str3: "34")

// 协议和类方法中的 Self
protocol Copyable {
    func copy() -> Self
}

class MyClass: Copyable {
    var num = 1
    func copy() -> Self {
        let resutl = type(of: self).init()
        resutl.num = num
        return resutl
    }

    required init() {
    }
}

let object = MyClass()
object.num = 100

let newObject = object.copy()
object.num = 1

print(object.num)
print(newObject.num)

// 动态类型和多方法
class Pet{}
class Cat: Pet {}
class Dog: Pet {}

func printPet(_ pet: Pet) {
    print("Pet")
}

func printPet(_ cat: Cat) {
    print("Meow")
}

func printPet(_ dog: Dog) {
    print("Bark")
}

printPet(Cat())
printPet(Dog())
printPet(Pet())


//func printThem(_ pet: Pet, _ cat: Cat) {
//    printPet(pet)
//    printPet(cat)
//}
//
//printThem(Dog(), Cat())
// Pet
// Meow

func printThem(_ pet: Pet, _ cat: Cat) {
    if let aCat = pet as? Cat {
        printPet(aCat)
    } else if let aDog = pet as? Dog {
        printPet(aDog)
    }
    printPet(cat)
}

// 属性观察
print("属性观察")
class A {
    var number: Int {
        get {
            print("get")
            return 1
        }

        set {
            print("set")
        }
    }
}

class B: A {
    override var number: Int {
        willSet {
            print("willSet")
        }
        didSet {
            print("didSet")
        }
    }
}


// didSet 需要在 set 前捕获 oldValue 所以会调用 get
let b = B()
b.number = 0

// final

//: [Next](@next)
