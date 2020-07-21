//: [Previous](@previous)

import Foundation

let diceFaceCount: UInt32 = 6

for _ in 0..<10 {
    let randomRoll = Int(arc4random_uniform(diceFaceCount)) + 1
    print(randomRoll)
}

func random(in range: Range<Int>) -> Int {
    let count = UInt32(range.endIndex - range.startIndex)
    return Int(arc4random_uniform(count)) + range.startIndex
}

//for _ in 0...100 {
//    let range = Range<Int>(1...6)
//    print(random(in: range))
//}

// pring 和 debugPrint
class MyClass {
    var num: Int
    init() {
        num = 1
    }
}

let obj = MyClass()
print(obj)

struct Meeting {
    var date: NSDate
    var place: String
    var attendeeName: String
}

let meeting = Meeting(date: NSDate(timeIntervalSinceNow: 86400),
                      place: "会议室81",
                      attendeeName: "小明")

print(meeting)

extension Meeting: CustomStringConvertible {
    var description: String {
        return "于 \(self.date) 在 \(self.place) 与 \(self.attendeeName) 进行会议"
    }
}

//let d = NSData()
//
//do {
//    try d.write(toFile: "Hello", options: [])
//} catch let error as NSError {
//    print("Error: \(error.domain)")
//}

enum LoginError: Error {
    case UserNotFound, UserPasswordNotMatch
}

let users: [String: String] = ["me": "123qwe"]

func login(user: String, password: String) throws {
    if !users.keys.contains(user) {
        throw LoginError.UserNotFound
    }
    
    if users[user] != password {
        throw LoginError.UserPasswordNotMatch
    }
    
    print("Login successfully")
}
do {
    try login(user: "me", password: "123qwe")
} catch LoginError.UserNotFound {
    print("UserNotFound")
} catch LoginError.UserPasswordNotMatch {
    print("UserPasswordNotMatch")
}

enum Result {
    case Success(String)
    case Error(NSError)
}

func doSomethingParam(param: AnyObject) -> Result {
    
    let success = random(in: Range(0...1)) > 0
    if success {
        return Result.Success("成功完成")
    } else {
        let error = NSError(domain: "errorDomain", code: 1, userInfo: nil)
        return Result.Error(error)
    }
}

let result = doSomethingParam(param: "测试" as AnyObject)
switch result {
case let .Success(ok):
    let serverResponse = ok
case let .Error(error):
    let serverResponse = error.description
}

let absoluteZeroInCelsius: Double = -273.15

func convertToKelvin(_ celsius: Double) -> Double {
    assert(celsius > absoluteZeroInCelsius, "输入的摄氏温度不能低于绝对零度")
    return celsius - absoluteZeroInCelsius
}

let roomTemperature = convertToKelvin(27)
//let tooCold = convertToKelvin(-300)

//我们在 Swift Compiler - Custom Flags 中的 Other Swift Flags 中添加 -assert-config Debug 来强制启用断言，或者 -assert-config Release 来强制禁用断言。

// fatalError
//let array: NSArray = [1, 2, 3]
//array[100]

let array = [1, 2, 3]
//array[100]

enum MyEnum {
    case Value1, Value2, Value3
}

func check(someValue: MyEnum) -> String {
    switch someValue {
    case .Value1:
        return "OK"
    case .Value2:
        return "Mybe OK"
    default:
        fatalError("Should not show!")
    }
}

//check(someValue: .Value3)

// 确保子类实现这些方法，而父类中的方法不被错误地调用，我们就可以 利用 fatalError 来在父类中强制抛出错误

import UIKit
enum ImageName: String {
    case myImage = "my_image"
}

enum SegueName: String {
    case mySegue = "my_segue"
}

extension UIImage {
    convenience init!(imageName: ImageName) {
        self.init(named: imageName.rawValue)
    }
}

extension UIViewController {
    func performSegue(withName segueName: SegueName, sender: Any?) {
        performSegue(withIdentifier: segueName.rawValue, sender: sender)
    }
}

let image = UIImage(imageName: .myImage)

//performSegue(withName: .mySegue, sender: self)

// Playground 延迟运行

class MyClass1 {
    @objc func callMe() {
        print("Hi")
    }
}
let object1 = MyClass1()

//Timer.scheduledTimer(timeInterval: 1,
//                     target: object1,
//                     selector: #selector(MyClass1.callMe),
//                     userInfo: nil,
//                     repeats: true)


let jsonString = """
{"menu": {
    "id": "file",
    "value": "File",
    "popup": {
        "menuitem": [
            {"value": "New", "onclick": "CreateNewDoc()"},
            {"value": "Open", "onclick": "OpenDoc()"},
            {"value": "Close", "onclick": "CloseDoc()"}
        ]
    }
}}
"""

struct Obj: Codable {
    let menu: Menu
    struct Menu: Codable {
        let id: String
        let value: String
        let popup: Popup
    }

    struct Popup: Codable {
        let menuItem: [MenuItem]
        enum CodingKeys: String, CodingKey {
            case menuItem = "menuitem"
        }
    }

    struct MenuItem: Codable {
        let value: String
        let onClick: String

        enum CodingKeys: String, CodingKey {
            case value
            case onClick = "onclick"
        }
    }
}

let data = jsonString.data(using: .utf8)!
do {
    let obj = try JSONDecoder().decode(Obj.self, from: data)
    let value = obj.menu.popup.menuItem[0].value
    print(value)
} catch {
    print("出错了: \(error)")
}

//: [Next](@next)"
