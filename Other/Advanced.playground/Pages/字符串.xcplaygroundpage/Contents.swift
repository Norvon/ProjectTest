//: [Previous](@previous)

import Foundation
"\u{20AC}"
// 字符簇和标准等价
"\u{00e9}".count // 1
"e\u{0301}".count // 1

"\u{00e9}" == "e\u{0301}"
"\u{00e9}".unicodeScalars.count
"e\u{0301}".unicodeScalars.count

let single = "Pok\u{00E9}mon"
let double = "Poke\u{0301}mon"
single.count
double.count

single.unicodeScalars.count
double.unicodeScalars.count

let nssingle = single as NSString
nssingle.length
let nsdouble = double as NSString
nsdouble.length

single.utf8.elementsEqual(double.utf8)

let f = "👨\u{200D}👩\u{200D}👧\u{200D}👦"
"👨\u{200D}⚕"
// 字符串和集合
let flagLetterC = "🇨"
let flagLetterN = "🇳"

let flag = flagLetterC + flagLetterN

extension String {
    var allPrefixes1: [Substring] {
        return (0...count).map { (i) -> Substring in
//            print(self)
            return self.prefix(i)
        }
//        (prefix)
    }
}
var hello = "Hello"
hello.allPrefixes1

extension String {
    var allPrefixes2: [Substring] {
        return [""] + indices.map { index -> Substring in
            print(type(of: self))
            return self[...index]
        }
    }
}

hello.allPrefixes2

// 范围可替换，而非可变
var greeting = "Hello, world!"
if let comma = greeting.firstIndex(of: ",") {
    greeting[..<comma]
    greeting.replaceSubrange(comma..., with: " again.")
}
greeting

// 字符串索引
let s = "abcdef"
let second = s.index(after: s.startIndex)
s[s.startIndex]
s[second]
let sixth = s.index(second, offsetBy: 4)
s[sixth]

let safeIdx = s.index(s.startIndex, offsetBy: 100, limitedBy: s.endIndex)
safeIdx
s[..<s.index(s.startIndex, offsetBy: 4)]
s.prefix(4)

let date = "2020-09-01"
date.split(separator: "-")[1]
date.dropFirst(5).prefix(2)

hello = "Hello!"
if let idx = hello.firstIndex(of: "!") {
    hello.insert(contentsOf: ", world", at: idx)
}
hello

func parse(cvs: String) -> [[String]] {
    var result: [[String]] = [[]]
    var currentField = ""
    var inQuotes = false
    for c in cvs {
        switch (c, inQuotes) {
        case (",", false):
            print("引号外的逗号， 表示当前字段的结束")
            result[result.endIndex - 1].append(currentField)
            currentField.removeAll()
        case ("\n", false):
            print("引号外的换行，表示结束当前行")
            result[result.endIndex - 1].append(currentField)
            currentField.removeAll()
            result.append([])
        case ("\"", _):
            print("读到引号，用于切换 inQuotes")
            inQuotes = !inQuotes
        default:
            currentField.append(c)
        }
    }
    result[result.endIndex - 1].append(currentField)
    return result
}
let csv = #"""
"Values in quotes","can contain , characters"
"Values without quotes work as well:",42
"""#
parse(cvs: csv)

// 子字符串
var sentence = "The quick brown fox jumped over ther lazy dog."
let firstSpace = sentence.firstIndex(of: " ") ?? sentence.endIndex
let firstWord = sentence[..<firstSpace]
type(of: firstWord)

let poem = """
Over the wintry
forest, winds howl in rage
with no leaves to blow.
"""
let lines = poem.split(separator: "\n")
lines
type(of: lines)


extension String {
    func wrapped(after maxLength: Int = 70) -> String {
        var lineLength = 0
        let lines = self.split(omittingEmptySubsequences: false) {
            character in
            if character.isWhitespace && lineLength >= maxLength {
                lineLength = 0
                return true
            } else {
                lineLength += 1
                return false
            }
        }
        print("---------\(lines)")
        return lines.joined(separator: "\n")
    }
}

let temp = "放点辣椒 放的开垃圾发电克 拉就分开了多久啊封疆大吏 肌肤抵抗附近的垃 圾都分开了"
print(temp.wrapped(after: 2))


extension Collection where Element: Equatable {
    func splitt<S: Sequence>(separators: S) -> [SubSequence]
        where Element == S.Element {
            return split {
                separators.contains($0)
            }
    }
}

"Hello, world!".splitt(separators: ",!")

// StringProtocol
func lastWord(in input: String) -> String? {
    let words = input.splitt(separators: [",", " "])
    guard let lastWord = words.last else { return nil }
    return String(lastWord)
}

print(lastWord(in: "one, tow, three, four, five") ?? "")
// 子字符串会一直持有整个原始字符串
let substring = sentence[...]

let commaSeparatednumbers = "1,2,3,4,5"
let numbers = commaSeparatednumbers.split(separator: ",").compactMap { Int($0) }
numbers

// 不要声明任何新的遵守 StringProtocol 协议的类型。只有标准库中的 String 和 Substring 是有效的适配类型。

// 编码单元视图
let tweet = "Having ☕️ in a cafe\u{301} in 🇮🇹 and enjoying the 🌞."
let characterCount = tweet.precomposedStringWithCanonicalMapping.unicodeScalars.count

// Swift 和 C 的字符串转换不会带来任何额外的系统开销，因为 Swift 可以直接 把指向字符串内部存储的指针传递给 C。

for i in Array(tweet) {
    print(i, terminator: "->")
}
print()

// 共享索引
let pokemon = "Poke\u{301}mon"
if let index = pokemon.firstIndex(of: "é") {
    let scalar = pokemon.unicodeScalars[index]
    String(scalar)
}

// 字符串和 Foundation
import UIKit
sentence = """
The quick brown fox jumped \
over the lazy dog.
"""

var words: [String] = []
sentence.enumerateSubstrings(in: sentence.startIndex..., options: .byWords,
                             { (word, range, _, _) in
                                guard let word = word else { return }
                                words.append(word)
}
)
words

let text = "👉 Click here for more info."
let linkTarget = URL(string: "https://www.youtube.com/watch?v=DLzxrzFCyOs")!

let formatted = NSMutableAttributedString(string: text)

if let linkRange = formatted.string.range(of: "Click here") {
    let nsRange = NSRange(linkRange, in: formatted.string)
    formatted.addAttribute(.link, value: linkTarget, range: nsRange)
}

if let queryRange = formatted.string.range(of: "here") {
    let nsRange = NSRange(queryRange, in: formatted.string)
    var attributesRange = NSRange()
    let attributes = formatted.attributes(at: nsRange.location, effectiveRange: &attributesRange)
    attributes
    attributesRange
    
    if let effectiveRange = Range(attributesRange, in: formatted.string) {
        formatted.string[effectiveRange]
    }
}

let lowercaseLetters = ("a" as Character)..."z"

// 只有实现了这个协议的范围才是可数的集合
//for c in lowercaseLetters {
//    print(c)
//}

// String 和 Character 的内部结构
// 字符串字面量
// 字符串插值
// 定制字符串描述
// CustomDebugStringConvertible

// 文本输出流
var s1 = ""
let numbers1 = [1, 2, 3, 4, 5]
print(numbers1, to: &s1)
s1

struct ArrayStream: TextOutputStream {
    var buffer: [String] = []
    mutating func write(_ string: String) {
        buffer.append(string)
    }
}

var stream = ArrayStream()
print("Hello", to: &stream)
print("World", to: &stream)
stream.buffer

struct ReplacingStream: TextOutputStream, TextOutputStreamable {
    let toReplace: KeyValuePairs<String, String>
    private var output = ""

    init(replacing toReplace: KeyValuePairs<String, String>) {
        self.toReplace = toReplace
    }

    mutating func write(_ string: String) {
        let toWrite = toReplace.reduce(string) { partialResult, pair in
            partialResult.replacingOccurrences(of: pair.key, with: pair.value)
        }
        print(toWrite, terminator: "", to: &output)
    }

    func write<Target>(to target: inout Target) where Target : TextOutputStream {
        output.write(to: &target)
    }
}

var replacer = ReplacingStream(replacing: ["in the cloud": "on someone else's computer"])
let souce = "People find it convenient to store their data in the cloud."
print(souce, terminator: "", to: &replacer)

var output = ""
print(replacer, terminator: "", to: &output)
output
//: [Next](@next)
