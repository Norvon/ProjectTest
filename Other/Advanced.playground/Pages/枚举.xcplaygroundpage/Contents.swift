//: [Previous](@previous)

import Foundation
enum TextAlignment {
    case left
    case center
    case right
}

@_frozen enum Optional<Wrapped> {
    case none
    case some(Wrapped)
}

enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

let alignment = TextAlignment.left
let download: Result<String, Error> = .success("<p>Hello world!</p>")

// 枚举是值类型
// * 枚举可以有方法，计算属性和下标操作。
// * 方法可以别生命为可变和不可变。
// * 你可以为枚举实现扩展。
// * 枚举可以实现各种协议。
// * 枚举不能拥有存储属性。

extension TextAlignment {
    init(defaultFor locale: Locale) {
        guard let language = locale.languageCode else {
            self = .left
            return
        }

        switch Locale.characterDirection(forLanguage: language) {
        case .rightToLeft:
            self = .right
        case .leftToRight,
             .topToBottom,
             .bottomToTop,
             .unknown:
            self = .left
        @unknown default:
            self = .left
        }
    }
}

let english = Locale(identifier: "en_AU")
TextAlignment(defaultFor: english)
let arabic = Locale(identifier: "ar_EG")
TextAlignment(defaultFor: arabic)

// 总和类型和乘积类型
// 一个元组（或者结构体，类）的居民数量，等于其成员的居民数量的乘积。因此，结构体，类和元组也被称为乘积类型
// 一个枚举的居民数量，等于它所成员的居民数量的总和，总和类型
enum PrimacyColor {
    case red
    case yellow
    case blue
}

enum ExtendedColor {
    case red
    case yellow
    case blue
    case gray(brightness: UInt8)
}

// 支持的模式类型
// * 通配符模式 _
// * 元组模式 ()
// * 枚举成员模式
// * 值绑定模式
// * 可选值模式
// * 类型转换模式
// * 表达式模式


//: [Next](@next)
