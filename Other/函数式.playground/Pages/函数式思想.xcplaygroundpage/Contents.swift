//: [Previous](@previous)

import Foundation

typealias Distance = Double

struct Position {
    var x: Double
    var y: Double
}

extension Position {
    func within(range: Distance) -> Bool {
        return sqrt(x*x + y*y) <= range
    }
    
    func minus(_ p: Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }
    
    var length: Double {
        return sqrt(x * x + y * y)
    }
}

struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}

extension Ship {
    //    func canEngage(ship target: Ship) -> Bool {
    //        let dx = target.position.x - position.x
    //        let dy = target.position.y - position.y
    //        let targetDistance = sqrt(dx * dx + dy * dy)
    //        return targetDistance <= firingRange
    //    }
    
    //    func canSafelyEngage(ship target: Ship) -> Bool {
    //        let dx = target.position.x - position.x
    //        let dy = target.position.y - position.y
    //        let targetDistance = sqrt(dx * dx + dy * dy)
    //        return targetDistance <= firingRange && targetDistance > unsafeRange
    //    }
    
    //    func canSafelyEngage(ship target: Ship, friendly: Ship) -> Bool {
    //        let dx = target.position.x - position.x
    //        let dy = target.position.y - position.y
    //        let targetDistance = sqrt(dx * dx + dy * dy)
    //
    //        let friendlyDx = friendly.position.x - target.position.x
    //        let friendlyDy = friendly.position.y - target.position.y
    //        let friendlytargetDistance = sqrt(friendlyDx * friendlyDx + friendlyDy * friendlyDy)
    //        return targetDistance <= firingRange
    //            && targetDistance > unsafeRange
    //            && friendlytargetDistance > unsafeRange
    //    }
    
    func canSafelyEngage(ship target: Ship, friendly: Ship) -> Bool {
        
        let targetDistance = target.position.minus(position).length
        
        let friendlytargetDistance = friendly.position.minus(target.position).length
        return targetDistance <= firingRange
            && targetDistance > unsafeRange
            && friendlytargetDistance > unsafeRange
    }
}

// 函数式编程的核心理念就是 函数是值，它和结构体、整型或是布尔型没有什么区别 —— 对函数使用另外一套命名规则会 违背这一理念。

typealias Region = (Position) -> Bool
func circle(radius: Distance) -> Region {
    return { point in point.length <= radius }
}

func circle2(radius: Distance, center: Position) -> Region {
    return { point in point.minus(center).length <= radius }
}

func shift(_ region: @escaping Region, by offset: Position) -> Region {
    return { point in region(point.minus(offset)) }
}

// 圆心(5,5) r = 10
let shifted = shift(circle(radius: 10), by: Position(x: 5, y: 5))

func invert(_ region: @escaping Region) -> Region {
    return {point in !region(point)}
}

func intersect(_ region: @escaping Region, with other: @escaping Region) -> Region {
    return {point in region(point) && other(point)}
}

func union(_ region: @escaping Region, with other: @escaping Region) -> Region {
    return {point in region(point) || other(point)}
}



print(#file, #line)
//: [Next](@next)
