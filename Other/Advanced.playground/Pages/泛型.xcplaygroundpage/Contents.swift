//: [Previous](@previous)

import Foundation

func identity<A>(_ value: A) -> A {
    return value
}

enum BinaryTree<Element> {
    case leaf
    indirect case node(Element, l: BinaryTree<Element>, r: BinaryTree<Element>)
    init(_ value: Element) {
        self = .node(value, l: .leaf, r: .leaf)
    }
}

let tree: BinaryTree<Int> = .node(5, l: .leaf, r: .leaf)

// 扩展泛型类型
extension BinaryTree {
    var values: [Element] {
        switch self {
        case .leaf:
            return []
        case let .node(el, left, right):
            return left.values + [el] + right.values
        }
    }
    
    func map<T>(_ transform: (Element) -> T) -> BinaryTree<T> {
        switch self {
        case .leaf:
            return .leaf
        case let .node(el, left, right):
            return .node(transform(el),
                         l: left.map(transform),
                         r: right.map(transform))
        }
    }
}

tree.values

let incremented: BinaryTree<Int> = tree.map { $0 + 1 }
incremented
let stringValues: [String] = tree.map { "\($0)" }.values

// 泛型和 Any
// 基于泛型的设计

struct Resource<A> {
    let url: URL
    let parse: (Data) throws -> A
}

extension URLSession {
    func load<A>(_ r: Resource<A>,
                 callback:@escaping (Ressult<A, Error>) -> ()) {
        dataTask(with: r)
    }
}


//: [Next](@next)
