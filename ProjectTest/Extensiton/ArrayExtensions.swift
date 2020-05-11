//
//  ArrayExtensions.swift
//  ProjectTest
//
//  Created by nor on 2020/5/11.
//  Copyright © 2020 nor. All rights reserved.
//

import Foundation

public func == <T: Equatable>(lhs: [T]?, rhs:[T]?) -> Bool {
    switch (lhs, rhs) {
    case let (lhs?, rhs?):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}

extension Array {
    public func containsType<T>(of element: T) -> Bool {
        let elementType = type(of: element)
        return contains { type(of: $0) == elementType}
    }
    
    public func decompose() -> (head: Iterator.Element, tail: SubSequence)? {
        return (count > 0) ? (self[0], self[1..<count]) : nil
    }
    
    public func forEachEnumerated(_ body: @escaping (_ offset: Int, _ element: Element) -> Void) {
        enumerated().forEach(body)
    }
    
    public func get(at index: Int) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }
        return self[index]
    }
    
    public mutating func insertFirse(_ newElement: Element) {
        insert(newElement, at: 0)
    }
    
    public func random() -> Element? {
        guard count > 0 else {
            return nil
        }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    
    public func reverseIndex(_ index: Int) -> Int? {
        guard index >= 0 && index < count else {
            return nil
        }
        return Swift.max(count - 1 - index, 0)
    }
    
    public mutating func shuffle() {
        guard count > 1 else {
            return
        }
        var j: Int
        for i in 0..<(count - 2) {
            j = Int(arc4random_uniform(UInt32(count - i)))
            if i != i + j {
                self.swapAt(i, i + j)
            }
        }
    }
    
    public func shuffled() -> Array {
        var result = self
        result.shuffle()
        return result
    }
    
    public func takeMax(_ n: Int) -> Array {
        return Array(self[0..<Swift.max(0, Swift.min(n, count))])
    }
    
    public func testAll(_ body: @escaping (Element) -> Bool) -> Bool {
        return !contains {
            !body($0)
        }
    }
    
    public func testAll(is condition: Bool) -> Bool {
        return testAll { ($0 as? Bool) ?? !condition == condition}
    }
}
