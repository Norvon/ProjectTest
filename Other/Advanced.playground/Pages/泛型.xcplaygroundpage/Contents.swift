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

// 1. 确定一个人物的公共执行模式
// 2. 把执行这个任务的代码模版抽象成一个泛型方法。
// 3. 允许方法的调用者通过泛型参数和汗水参数，在每次调用时泛型方法时，注入需要自定义的内容


//: [Next](@next)
