//: [Previous](@previous)

import Foundation
import UIKit

// mutating 关键字修身方法是为了能在该方法中修改 struct 或者 enum 的变量，所以如果你没在协议方法里写 mutating 的话，别人如果用 struct 或者 enum 来实现这个协议的话，就不能在方法里改变自己的变量了。
// 如：
protocol Vehicle {
    var numberofWheels: Int { get }
    var color: UIColor { get set }
    
   mutating func changeColor() // 去掉 mutating 会导致美剧和结构体编译报错
}

struct MyCar: Vehicle {
    mutating func changeColor() {
        color = .red
    }
    
    let numberofWheels = 4
    var color: UIColor = .blue
}

class BigCar: Vehicle {
    let numberofWheels: Int = 5
    var color: UIColor = .white
    
    func changeColor() {
        color = .black
    }
}

var myCar = MyCar()
myCar.color
myCar.changeColor()
myCar.color

let bigCar = BigCar()
bigCar.color
bigCar.changeColor()
bigCar.color


//: [Next](@next)
