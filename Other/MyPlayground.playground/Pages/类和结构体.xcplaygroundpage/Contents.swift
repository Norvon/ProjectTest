// 你在一个文件中定义一个类或者结构体， 则系统将会自动生成面向其他代码的外部接口。

// 相同
// 定义属性用来存储值
// 定义方法用于提供功能
// 定义下标脚本用来允许使用下标语法访问值
// 定义初始化器用于初始化状态
// 可以被扩展来默认所没有的功能
// 遵循协议来针对特定类型提供标准功能

// 类特别的功能
// 继承允许一个类继承另一个类的特征
// 类型转换允许你在运行检查和解释一个类实例的类型
// 反初始化器允许一个类实例释放任何其所被分配的资源
// 引用计数不止一个对类实例的引用

// 结构体在你的代码中通过复制来传递，并且并不会使用引用计数

class SomeClass {
    
}

struct SomeStructure {
    
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoModel = VideoMode()

print("The width of someResolution is \(someResolution.width)")

someVideoModel.resolution.width = 1280
print("The width of someVideoMod is now \(someVideoModel.resolution.width)")

let vga = Resolution(width: 640, height: 480)

// 结构体和枚举是值类型
// 值类型是一种当它被指定到常量和变量，或者被传递给函数时会被拷贝的类型
// 整数，浮点数，布尔量，字符串，数组和字典 都是值类型，并且都是以结构体的形式在后台实现的。

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")

enum CompassPoint {
    case North, South, East, West
}
var currentDirectiion = CompassPoint.West
let rememberdDirection = currentDirectiion
currentDirectiion = .East
if rememberdDirection == .West {
    print("The remembered direction is still .West")
}

// 类是引用类型
// 不同于值类型，在引用类型被赋值到一个常量，变量或者本身被传递到一个函数的时候它是不会被拷贝的。相对于拷贝，这里使用的是同一个对现存实例的引用

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

// 特征运算
// 应为类是引用类型，在后台有可能有很多常量都是引用到了同一个类的实例。（相同这词对结构体和枚举来说并不是真的相同，因为他们在赋予给常量，变量或者被传递给一个函数时总是被拷贝过去对。）
// 相同于 ( ===)
// 不相同于( !==)

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoModel instance.")
}

