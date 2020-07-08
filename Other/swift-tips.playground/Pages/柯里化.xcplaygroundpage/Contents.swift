import UIKit

func addOne(number: Int) -> Int {
    return number + 1
}

// 返回一个函数
func addTo(_ adder: Int) -> (Int) -> Int {
    return {
        num in
        return num + adder
    }
}
let addTwo = addTo(2)
let result = addTo(6)

func greaterThan(_ comparer: Int) -> (Int) -> Bool {
    return { return $0 > comparer }
}

let greaterThan10 = greaterThan(10)
greaterThan10(12)
greaterThan10(1)

// 安全的Selector
protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject>: TargetAction {
    weak var target: T?
    let action: (T) -> () -> ()
    
    func performAction() {
        if let t = target {
            action(t)()
        }
    }
}

enum ControlEvent {
    case TouchUpInside
    case ValueChanged
}

class Control {
    var actions = [ControlEvent: TargetAction]()
    func setTarget<T: AnyObject>(target: T,
                                 action: @escaping (T) -> () -> (),
                                 controlEvent: ControlEvent) {
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    
    func performActionForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}


// other
class BankAccount {
    var balance: Double = 0.0
    func deposit(_ amount: Double) {
        balance += amount
    }
}

let acount = BankAccount()
acount.deposit(100)
acount.balance

let depositor = BankAccount.deposit(_:)
depositor(acount)(100)
acount.balance

//: [Next](@next)
