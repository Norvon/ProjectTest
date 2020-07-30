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
        return (0...count).map(prefix)
    }
}
let hello = "Hello"
hello.allPrefixes1
//: [Next](@next)
