import Foundation

// 计算属性可以由类、结构体和枚举定义，存储属性只能由类和结构体定义
// 变量存储属性 var
// 常量存储属性 let

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 6

print(rangeOfThreeItems)
print(rangeOfFourItems)

// 延迟存储
// 多线程访问懒加载，无法保证属性只初始化一次
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let mamager = DataManager()
mamager.data.append("Some data")
mamager.data.append("Some more data")
print(mamager.importer.fileName)



// 计算属性
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            return Point(x: origin.x + (size.width / 2),
                         y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volue of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

// 属性观察者
class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("About to set totalSteps to \(newValue)")
        }
        didSet {
            if totalSteps > oldValue {
                totalSteps = 100
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896
print(stepCounter.totalSteps)

//// 属性包装
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12)}
    }

    init(_ number: Int) {
        self.number = number
    }
}

struct SmallRectangele {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

@propertyWrapper
struct SmallNumber {
    private var number = 0
    var projectedValut = false
    var wrappedValue: Int {
        get {
            return number
        }
        
        set {
            if newValue > 12 {
                number = 12
                projectedValut = true
            } else {
                number = newValue
                projectedValut = false
            }
        }
    }
    
    init(_ number: Int, projectedValut: Bool) {
        self.number = number
        self.projectedValut = projectedValut
    }
}

//struct SomeStructure {
//    @SmallNumber
//    var someNumber: Int
//}

//var someStructure = SomeStructure(someNumber: <#SmallNumber#>)

// 类型属性语法

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

SomeStructure.storedTypeProperty
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
print(SomeEnumeration.computedTypeProperty)
print(SomeClass.computedTypeProperty)

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}
