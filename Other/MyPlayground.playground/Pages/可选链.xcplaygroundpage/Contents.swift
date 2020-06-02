import Foundation

// 可选链
// ？ 可选链会在可选项为 nil 时得体地失败，
// ！ 强制展开则在可选项为 nil 时触发运行时错误。

//class Residence {
//    var numberOfRooms = 1
//}
//
//class Person {
//    var residence: Residence?
//}
//
//let john = Person()
// let roomCount = john.residence!.numberOfRooms // 会运行时报错

//if let roomCount = john.residence?.numberOfRooms {
//    print("john's residence has \(roomCount) room(s).")
//} else {
//    print("Unable to retrieve the number of rooms.")
//}

//john.residence = Residence()
//if let roomCount = john.residence?.numberOfRooms {
//    print("john's residence has \(roomCount) room(s).")
//} else {
//    print("Unable to retrieve the number of rooms.")
//}

// 为可选链定义模型类
class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber!) \(street!)"
        } else {
            return nil
        }
    }
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Person {
    var residence: Residence?
}


let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress // john.residence 目前是 nil

func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

john.residence?.address = createAddress() // createAddress() 不会被调用

// 通过可选链调用方法
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
