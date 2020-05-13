//: [Previous](@previous)

import UIKit

// 控制流

let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a",
     "A":
    print("This letter A")
default:
    print("Not the letter A")
}

let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "sevral"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}

print("There are \(naturalCount) \(countedThings)")

// for-in 循环
let names = ["Anna", "Alex", "Brian", "Jack" ]
for  (index, name) in names.reversed().enumerated() {
    print("\(index) Hello, \(name)!")
}

// 字典
var namesOfIntegers = [Int: String]()
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]

var airprots = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

if let oldValue = airprots.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue)")
}

// 可以用value = nil 的方法删除该元素
// airprots["YYZ"] = nil
print(airprots)

print(airprots.keys)

// 集合
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitTPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
oddDigits.intersection(evenDigits).sorted()
oddDigits.subtracting(singleDigitTPrimeNumbers).sorted()
oddDigits.symmetricDifference(singleDigitTPrimeNumbers).sorted()

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
favoriteGenres.count
favoriteGenres.remove("Rock")
print(favoriteGenres)

for genre in favoriteGenres {
    print("\(genre)")
}

var letters = Set<Character>()
letters.insert("a")
letters.insert("a")
//letters = []
print(letters)


// 数组
let arr = ["zero"]
let tempArr = ["zero", "zero"]

tempArr.first.hashValue == tempArr.last.hashValue


var shoppingList = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight"]
shoppingList[4...6] = ["x", "y", "z", "a"]
shoppingList.insert("Maple Syrup", at: 0)
print(shoppingList)

let mapleSyrup = shoppingList.remove(at: 0)
shoppingList.last

for (idx, value) in shoppingList.enumerated() {
    print("item \(idx + 1): \(value)")
}

var someInts = [Int]()
someInts.append(3)
someInts = []
print(someInts.count)


let str1: [String] = ["12", "12", "13"]
let str2: [String] = ["3"]
str1 + str2

str2.isEmpty
// MARK: - 字符串和字符
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}

print(act1SceneCount)

let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
unusualMenagerie.count

var word = "cafe"
word += "\u{301}"
print(word.count)
for w in word {
    print(w)
}

let greeting = "Guten Tag!"
greeting[greeting.startIndex]
for index in greeting.indices {
    print(index)
}
// 扩展字形集群
let enclosedEAcute: Character = "\u{20dd}\u{20dd}"
print(enclosedEAcute)

// 字符串插值
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

print(#"Write an interpolated string in Swift using \#(multiplier)."#)

print(#"6 times 7 is \#(6 * 7)"#)

// 连接字符串和字符
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

let exclamationMark: Character = "!"
welcome.append(exclamationMark)

let dog = "Dog!🐶"
for c in dog {
    print(c)
}

let badStart = """
one
two

"""
let end = """
three
"""

print(badStart + end)

// # 字符串是值类型，在传递过程中会被复制过去，赋值给常量或者变量的时候也是一样。结构体和枚举都是值类型

var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    print("Nothing to see here")
}

var variableString = "Horse"
variableString += " and carriage"

var constantString = "Highlander"
constantString += " and another Highlander"

let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""

let lineBreaks = """

This string starts with a line break.
It also ends with a line break.

"""

let quotation1 = """
       The White Rabbit put on his spectacles.  "Where shall I begin,
       please your Majesty?" he asked.

       "Begin at the beginning," the King said gravely, "and go on
       till you come to the end; then stop."
"""

let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation marks \"\"\"
"""

#"Line 1\#nLine 2"#
###"Line1\###nLine2"###

let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#

print(threeMoreDoubleQuotationMarks)



// MARK: - 基本运算符
let names2 = ["Anna", "Alex", "Brian", "Jack"]

for name in names2[2...] {
    print(name)
}

for name in names2[...2] {
    print(name)
}


let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
print(oneMillion)
print(justOverOneMillion)

let age = -3
//assert(age >= 0, "A person's age cannot be less than zero")

precondition(age < 0, "Index must be greater than zero.")


5 % 2; 5 % -2

let minusSix = -6
let alsoMinusSix = +minusSix

class a {
}

let a1 = a()
let a2 = a1

a1 === a2

let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}

let arr1 = ["22", "123"]
let arr2 = ["22", "123"]

arr1 == arr2




