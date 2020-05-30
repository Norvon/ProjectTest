// 继承
// Swift 类不会从一个通用基类继承。你没有指定特定父类的类都会以基类的形式创建。
class Vehicle {
    var currentSpeed = 0.0
    var descripthon: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        
    }
}

let someVehicle = Vehicle()

class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.descripthon)")

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.descripthon)")

class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()

// 重写属性的GETTER和SETTER
class Car: Vehicle {
    var gear = 1
    override var descripthon: String {
        return super.descripthon + "in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.descripthon)")

// 重写属性观察器
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.descripthon)")

// 阻止重写
// 你可以通过标记为终点来阻止一个方法，属性或者下标脚本被重写。
// 通过在方法、属性或者下标脚本的关键字前写 final 修饰符
// 比如 final var, final func, funal class func, final subscript
// 可以用 final class 标记一整个类为终点
