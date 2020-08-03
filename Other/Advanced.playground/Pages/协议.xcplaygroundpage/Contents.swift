//: [Previous](@previous)

import Foundation
//
//extension Array {
//    func allEqual(_ compare:(Element, Element) -> Bool) -> Bool {
//        guard let f = first else { return true }
//        for el in dropFirst() {
//            guard compare(f, el) else { return false }
//        }
//        return true
//    }
//}

struct Eq<A> {
    let eq:(A, A) -> Bool
}

let eqInt: Eq<Int> = Eq { $0 == $1 }

extension Array {
    func allEqual(_ compare: Eq<Element>) -> Bool {
        guard let f = first else { return true }
        for el in dropFirst() {
            guard compare.eq(f, el) else { return false }
        }
        return true
    }
}

extension Eq {
    func notEqual(_ l: A, _ r: A) -> Bool {
        return !eq(l, r)
    }
}


extension Equatable {
    static func noEqual(_ l: Self, _ r: Self) -> Bool {
        return !(l == r)
    }
}

// 条件化协议实现
func eqArray<El>(_ eqElement: Eq<El>) -> Eq<[El]> {
    return Eq { arr1, arr2 in
        guard arr1.count == arr2.count else { return false }
        for (l, r) in zip(arr1, arr2) {
            guard eqElement.eq(l, r) else { return false }
        }
        return true
    }
}

// 使用协议进行设计
import UIKit
protocol DrawingContext {
    mutating func addEllipse(rect: CGRect, fill: UIColor)
    mutating func addRectagle(rect: CGRect, fill: UIColor)
}

extension CGContext: DrawingContext {
    func addEllipse(rect: CGRect, fill fillColor: UIColor) {
        setFillColor(fillColor.cgColor)
        fillEllipse(in: rect)
    }

    func addRectagle(rect: CGRect, fill fillColor: UIColor) {
        setFillColor(fillColor.cgColor)
        fill(rect)
    }
}

// 协议组合
typealias Codable = Decodable & Encodable

// 协议和关联类型
protocol IteratorProtocol {
    associatedtype Element
    mutating func next() -> Element?
}

protocol ViewController {}
protocol Restorable {
    associatedtype State: Codable
    var state: State { get set }
}

class MessagesVC: ViewController, Restorable {
    typealias State = MessagesState
    
    struct MessagesState: Codable {
        var messages: [String] = []
        var scrollPosition: CGFloat = 0
    }
    var state: MessagesState = MessagesState()
}

// 类型消除器
let seq = [1, 2, 3].lazy.filter { $0 > 1 }.map { $0  * 2 }
let anySeq = AnySequence(seq)

// 

//: [Next](@next)
