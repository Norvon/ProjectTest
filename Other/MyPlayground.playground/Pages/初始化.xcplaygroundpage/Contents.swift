//// 初始化
//struct Fahrenheit {
//    var temperature = 32.0
//}
//
//var f = Fahrenheit()
//print("The default temperature is \(f.temperature)° Fahrenheit")
//
//struct Celsius {
//    var temperatureInCelsius: Double
//    init(fromFahrenheit fahrenheit: Double) {
//        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
//    }
//    init(fromKelvin kelvin: Double) {
//        temperatureInCelsius = kelvin - 273.15
//    }
//}
//
//let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
//let freezingPointOfWater = Celsius(fromKelvin: 273.15)
//
//struct Color {
//    let red, green, blue: Double
//    init(red: Double, green: Double, blue: Double) {
//        self.red = red
//        self.green = green
//        self.blue = blue
//    }
//
//    init(white: Double) {
//        red = white
//        green = white
//        blue = white
//    }
//}
//
//let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
//let halfGray = Color(white: 0.5)
////let veryGreen = Color(0.0, 1.0, 0.0)
//
//struct Celsius {
//    var temperatureInCelsius: Double
//    init(fromFahrenheit fahrenheit: Double) {
//        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
//    }
//    init(fromKelvin kelvin: Double) {
//        temperatureInCelsius = kelvin - 273.15
//    }
//    init(_ celsius: Double) {
//        temperatureInCelsius = celsius
//    }
//}
//let bodyTemperature = Celsius(37.0)
//
//// 可选属性类型
//class SurveyQuestion {
//    var text: String
//    var response: String?
//    init(text: String) {
//        self.text = text
//    }
//    func ask() {
//        print(text)
//    }
//}
//
//let cheeseQuestion = SurveyQuestion(text: "Do you lick cheese?")
//cheeseQuestion.ask()
//cheeseQuestion.response = "Yes, I do like cheese."

// 在初始化中分配常量属性
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets. (But not with cheese.)"

class A {
    var a = 10
    var b = 20.0
}

let t = A()
print(t.a)

@propertyWrapper
struct Wrapper<T> {
    var wrappedValue: T
    
    var projectedValue: Wrapper<T> { return self }
    
    func foo() { print("Foo") }
}

struct HasWrapper {
    @Wrapper var x = 0
    
    func foo() {
        print(x) // `wrappedValue`
        print(_x) // wrapper type itself
        print($x) // `projectedValue`
    }
}

let h = HasWrapper()
h.foo()


struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init(){}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}


// 类类型的初始化器委托
// 1. 指定初始化器必须从它的直系父类调用指定初始化器
// 2. 便捷初始化器必须从相同的类里调用另一个初始化器
// 3. 便捷初始化器最终必须调用一个指定初始化器

// * 指定初始化器必须总是向上委托
// * 便捷初始化器总是横行委托

// 两段式初始化
// 在第一个阶段，每一个存储属性被引入类为分配了一个初始值
// 第二个阶段就开始了，每个类都有机会在新的实例准备使用之前来定制它的存储属性。

//阶段 1
//指定或便捷初始化器在类中被调用；
//为这个类的新实例分配内存。内存还没有被初始化；
//这个类的指定初始化器确保所有由此类引入的存储属性都有一个值。现在这些存储属性的内存被初始化了；
//指定初始化器上交父类的初始化器为其存储属性执行相同的任务；
//这个调用父类初始化器的过程将沿着初始化器链一直向上进行，直到到达初始化器链的最顶部；
//一旦达了初始化器链的最顶部，在链顶部的类确保所有的存储属性都有一个值，此实例的内存被认为完全初始化了，此时第一阶段完成。
//阶段 2
//从顶部初始化器往下，链中的每一个指定初始化器都有机会进一步定制实例。初始化器现在能够访问 self 并且可以修改它的属性，调用它的实例方法等等；
//最终，链中任何便捷初始化器都有机会定制实例以及使用 slef 。


// 初始化器的继承和重写
// swift 的子类不会默认继承父类的初始化器。

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheels"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

// 初始化器的自动继承
// 1. 如果你的子类没有定义任何指定初始化器，它会自动继承父类所有的指定初始化器。
// 2. 如果你的子类提供了所有父类指定初始化器的实现——要么是通过规则1继承来的，要么通过在定义中提供自定义实现的——那么它自动继承所有的父类便捷初始化器。

// 指定和便捷初始化器的实战
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let onetMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Gees", quantity: 6)

class ShoopingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "✅" : " ❌"
        return output
    }
}

var breakfastList = [
    ShoopingListItem(),
    ShoopingListItem(name: "Bacon"),
    ShoopingListItem(name: "Eggs", quantity: 6)
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

// 可失败初始化器
let wholeNumber: Double = 12345.0
let pi = 3.14159
if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to int maintains value")
}

let valueChanged = Int(exactly: pi)
if valueChanged == nil {
    print("\(pi) conversion to int does not maintain value")
}

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}

// 枚举的可失败初始化器
//enum TemperatureUnit {
//    case Kelvin, Celsius, Fahrenheit
//    init?(symbol: Character) {
//        switch symbol {
//        case "K":
//            self = .Kelvin
//        case "C":
//            self = .Celsius
//        case "F":
//            self = .Fahrenheit
//        default:
//            return nil
//        }
//    }
//}

//let fahrenheitUnit = TemperatureUnit(symbol: "F")
//if fahrenheitUnit != nil {
//    print("This is a defined temperature unit, so initalizatiion succeeded.")
//}
//
//let unknownUnit = TemperatureUnit(symbol: "X")
//if unknownUnit == nil {
//    print("This is not a defined temperature unit, so initialization faild.")
//}

// 带有原始值枚举的可失败初始化器
enum TemperatureUnit: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit = TemperatureUnit(rawValue: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initalizatiion succeeded.")
}

let unknownUnit = TemperatureUnit(rawValue: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization faild.")
}

// 初始化失败的传递
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil}
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initizlize zero shirts")
}

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}

// 重写可失败初始化器
print("重写可失败初始化器")
class Documet {
    var name: String?
    init() {}
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}

class AutomaticallyNamedDocument: Documet {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    override init?(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDcoument: Documet {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

// 必要初始化器
// 在类的初始化器前添加 required 修饰符来表明所有该类的子类都必须实现该初始化器
// 当子类重写父类的必要初始化器时，必须在子类的初始化器前同样添加 required 修饰符以确保当其它类集成该子类时，
// 该初始化器同为必要初始化器。在重写父类的必要初始化器时，不需要添加 override 修饰符
class SomeClass {
    required init() {
    }
}

class SomeSubclass: SomeClass {
    required init() {
        
    }
}

// 通过闭包和函数来设置属性的默认值
print("通过闭包和函数来设置属性的默认值")
struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        print(temporaryBoard)
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let chessboard = Chessboard()
print(chessboard.boardColors)
