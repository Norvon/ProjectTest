
var a = ["1", "2", "3"]
var b = ["4", "2", "3"]

a.append(contentsOf: b)
print(a)

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
