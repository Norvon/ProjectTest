//: [Previous](@previous)

func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}

func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}

greet(person: "Tim", alreadyGreeted: true)

func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty {return nil}
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    
    print("min is \(bounds.min) and max is \(bounds.max)")
}

// 隐式返回的函数
func greeting(for person: String) -> String {
    "Hello, " + person + "!"
}
print(greeting(for: "Dave"))

func anotherGreeting(for person: String) -> String {
    return "Hello , " + person + "!"
}
print(anotherGreeting(for: "Dave"))

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

print(arithmeticMean(1, 2, 3, 4, 5))
print(arithmeticMean(3, 8.25, 18.75))

// 输入输出形式参数
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    print(Unmanaged.passUnretained(a as AnyObject).toOpaque())
    print(Unmanaged.passUnretained(b as AnyObject).toOpaque())
    let tempA = a
    a = b
    b = tempA
}

var someInt = 3
var anotherInt = 107

print(Unmanaged.passUnretained(someInt as AnyObject).toOpaque())
print(Unmanaged.passUnretained(anotherInt as AnyObject).toOpaque())
swapTwoInts(&someInt, &anotherInt)

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

var mathFunction: (Int, Int) -> Int = addTwoInts

mathFunction(2, 3)

// 内嵌函数
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1}
    func stepBackward(input: Int) -> Int { return input - 1}
    return backward ? stepBackward : stepForward
}

var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)

while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}

print("zero!")
