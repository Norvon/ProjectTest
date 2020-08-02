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
//: [Next](@next)
