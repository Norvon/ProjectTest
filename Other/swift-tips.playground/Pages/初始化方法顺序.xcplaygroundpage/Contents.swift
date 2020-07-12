//: [Previous](@previous)

import Foundation

class Cat {
    var name: String
    init() {
        name = "cat"
    }
}

class Tiger: Cat {
    let power: Int
    override init() {
        power = 10
        super.init() // 视特定情况可以忽略，（不对父类进行修改）
        name = "tiger"
    }
}


// Designated, Convenience 和 Required
class ClassA {
    let numA: Int
   required init(num: Int) {
        numA = num
    }

    // 不能被资料重写，和从子类中通过 super 调用
    convenience init(bigNum: Bool) {
        self.init(num: bigNum ? 1000 : 1)
    }
}

class ClassB: ClassA {
    let numB: Int


//    override convenience init(bigNum: Bool) {
//        // Initializer does not override a designated initializer from its superclass
//    }

    required init(num: Int) {
        numB = num + 1
        super.init(num: num)
//        super.init(bigNum: true)
    }
}

let anObj = ClassB(bigNum: true)
print(anObj.numB)

// 初始化返回 nil
//: [Next](@next)
