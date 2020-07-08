//: [Previous](@previous)

import Foundation


class Toy {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Pet {
    var toy: Toy?
}

class Child {
    var pet: Pet?
}



let toyName = xiaoming.pet?.toy?.name

//: [Next](@next)
