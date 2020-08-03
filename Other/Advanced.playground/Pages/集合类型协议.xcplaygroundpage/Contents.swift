//: [Previous](@previous)

import Foundation
// Sequence 提供了迭代的能力。它允许你创建一个迭代器，但对于虚了是否只能单词遍历或者支持多次遍历，则不提供任何保障
// Collection 扩展了Sequence。它不仅是一个可以多次遍历的序列，还允许你通过索引访问其中的元素。并且，Collectiion 还通过 SubSequence 提供了集合切片的能力，而这个切片自身也是一个集合。
// MutableCollection 提供了可以在常数时间内，通过下标集合元素的能力。但它不允许向集合中添加删除元素。
// RangeReplaceableCollection 提供了替换集合中一个连续区间的元素的能力。通过扩展，这个能力还衍生出了诸如 append 和 remove 等方法。很多可变集合类型都可以进行区间进行内容替换，但其中也有例外。例如，最常用的 Set 和 Dictionary 就不支持这个操作，而 Array 和 String 则没有问题。
// BidirectiionalCollectiion 添加了从集合尾部向集合头部遍历的能力。显然，我们无法像这样遍历一个 Dictionary, 但“逆着”遍历一个字符串则没有问题。对于某些算法来说，逆向遍历是一个重要的操作
// RandomAccessCollection 扩展了 BidirectionalCollection， 添加了更有效率的索引计算能力： 它要求计算索引之间的距离或移动索引位置都是常数时间的操作
// LazySequenceProtocol 定义了一个只有在开始遍历时才计算其中元素的序列。
// LazyCollectionProtocol 和 LazySequenceProtocol 是类似的，指数它用于定义相同行为特征的集合类型。


// 序列
protocol Sequence {
    associatedtype Element
    associatedtype Iterator: IteratorProtocol
}

protocol IteratorProtocol {
    associatedtype Element
    mutating func next() -> Element?
}

// 迭代器和值语义
let seq = stride(from: 0, to: 10, by: 1)
var i1 = seq.makeIterator()
i1.next()
i1.next()

var i2 = i1
i1.next()
i1.next()
i2.next()
i2.next()

var i3 = AnyIterator(i1)
var i4 = i3

i3.next()
i4.next()
i3.next()
i3.next()

func fibsIterator() -> AnyIterator<Int> {
    var state = (0, 1)
    return AnyIterator {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

let fibsSequence = AnySequence(fibsIterator())
Array(fibsIterator().prefix(10))


let fibsSequence2 = sequence(state: (0, 1)) {
    (state) -> Int? in
    let upcomingNumber = state.0
    state = (state.1, state.0 + state.1)
    return upcomingNumber
}

Array(fibsSequence2.prefix(10))

func reanLine() {
    
}

// 单次遍历序列
let standardIn = AnySequence {
    return AnyIterator {
        reanLine()
    }
}

let numberedStdIn = standardIn.enumerated()
//for (i, line) in numberedStdIn {
//    print("\(i + 1): \(line)")
//}

// 序列和迭代器之间的关系
enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)
}

extension List {
    mutating func push(_ x: Element) {
        self = .node(x, next: self)
    }
    
    mutating func pop() -> Element? {
        switch self {
        case .end: return nil
        case let .node(x, next: tail):
            self = tail
            return x
        }
    }
}

extension List: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(into: .end, { (partialList, element) in
            partialList.push(element)
        })
    }
}
let list: List = [3, 2, 1]

// 集合类型
struct FIFOQueue<Element> {
    private var left: [Element] = []
    private var right: [Element] = []
    
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

let hello = "Hello"
let world = "World"
let helloIdx = hello.startIndex
world[helloIdx]


// 自定义集合索引
var str = "Still i see Monsters"
str.split(separator: " ")
var arr = [1, 11, 22, 2, 3, 4]
let t = arr.drop{ $0 >= 1 && $0 < 20}
t
arr

// 切片与原集合共享索引
let cities = ["New York", "Rio", "London", "Berlin", "Rome", "Beijing", "Tokyo", "Sydney"]
let slice = cities[2...4]
cities.startIndex // 0
cities.endIndex // 8
slice.startIndex // 2
slice.endIndex  // 5

// BidirectionalCollection      一个既支持前向又支持后向遍历的集合。
// RandomAccessCollection       一个支持高效随机访问索引进行遍历的集合。
// MutableCollection            一个支持下标赋值的集合。
// RangeReplaceableCollection   一个支持将任意子范围的元素用别等集合中的元素进行替换的集合。



//: [Next](@next)
