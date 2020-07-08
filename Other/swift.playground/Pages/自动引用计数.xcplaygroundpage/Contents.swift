//
//import Foundation
//// ARC
//class Person {
//    let name: String
//    init(name: String) {
//        self.name = name
//        print("\(name) is being initialized")
//    }
//    var apartment: Apartment?
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}
//
////var reference1: Person?
////var reference2: Person?
////var reference3: Person?
////
////reference1 = Person(name: "John Appleseed")
////reference2 = reference1
////reference3 = reference1
////
////reference1 = nil
////reference2 = nil
////reference3 = nil
//
//// 类实例之间的循环强引用
//class Apartment {
//    let unit: String
//    init(unit: String) {
//        self.unit = unit
//    }
//   weak var tenant: Person?
//    deinit {
//        print("Apartment \(unit) is being deinitialized")
//    }
//}
//
////import UIKit
////
////public extension UIView {
////    private struct AssociatedKey {
////        static var identifier: String = ""
////    }
////
////    var identifier: String {
////        get {
////            return objc_getAssociatedObject(self, &AssociatedKey.identifier) as? String ?? ""
////        }
////
////        set {
////            objc_setAssociatedObject(self, &AssociatedKey.identifier, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
////        }
////    }
////}
////
////class ViewController: UIViewController {
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        print("view's identifier:\(self.view.identifier)")
////        view.identifier = "root view"
////        print("view's identifier:\(self.view.identifier)")
////    }
////}
////ViewController().viewDidLoad()
////print(UIView().identifier)
//
//var john: Person?
//var unit4A: Apartment?
//john = Person(name: "John Appleseed")
//unit4A = Apartment(unit: "4A")
//
//john?.apartment = unit4A
//unit4A?.tenant = john
//
//
//john = nil
////unit4A = nil
//
//// 解决实例之间的循环引用
//// 对于生命周期中会变为nil的实例使用弱引用，
//// 对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用
//// 当引用可能“没有值”的时候，就使用弱引用来避免循环引用。如同在无主引用中描述的那样，如果引用始终有值，则可以使用无主引用来代替。
//
//// 弱引用，必须是可选类型
//
//// 无主引用
//class Customer {
//    let name: String
//    var card: CreditCard?
//    init(name: String) {
//        self.name = name;
//    }
//}
//
//class CreditCard {
//    let number: UInt64
//    unowned let customer: Customer
//    init(number: UInt64, customer: Customer) {
//        self.number = number
//        self.customer = customer
//    }
//    deinit {
//        print("Card #\(number) is being deinitialized")
//    }
//}
//
//print("UInt64.max \(UInt64.max)")
//print("Int.max \(Int.max)")
//
//// 无主可选引用
//class Department {
//    var name: String
//    var courses: [Course]
//    init(name: String) {
//        self.name = name
//        self.courses = []
//    }
//}
//
//class Course {
//    var name: String
//    unowned var department: Department
//    unowned var nextCourse: Course?
//    init(name: String, department: Department) {
//        self.name = name
//        self.department = department
//        self.nextCourse = nil
//    }
//}
//
//let department = Department(name: "Horticulture")
//
//let intro = Course(name: "Survey of Plants", department: department)
//let intermediate = Course(name: "Growing Common Herbs", department: department)
//let advanced = Course(name: "Caring for Tropical Plants", department: department)
//
//intro.nextCourse = intermediate
//intermediate.nextCourse = advanced
//department.courses = [intro, intermediate, advanced]
//
//// 无主引用和隐式展开的可选属性
//class Country {
//    let name: String
//    var capitalCity: City!
//    init(name: String, capitalName: String) {
//        self.name = name
//        self.capitalCity = City(name: capitalName, country: self)
//    }
//}
//
//class City {
//    let name: String
//    unowned let country: Country
//    init(name: String, country: Country) {
//        self.name = name
//        self.country = country
//    }
//}
//
//var country = Country(name: "Canada", capitalName: "Ottawa")
//print("\(country.name)'s capital city is called \(country.capitalCity.name)")
//
//class HTMLElement {
//    let name: String
//    let text: String?
//
//    lazy var asHTML: () -> String = {
//        [unowned self] in
//        if let text = self.text {
//            return "<\(self.name)>\(text)</\(self.name)>"
//        } else {
//            return "<\(self.name) />"
//        }
//    }
//
//    init(name: String, text: String? = nil) {
//        self.name = name
//        self.text = text
//    }
//
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}
//
//let heading = HTMLElement(name: "h1")
//let defaultText = "some default text"
//heading.asHTML = {
//    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
//}
//print(heading.asHTML())
//var paragraph: HTMLElement? = HTMLElement(name: "P", text: "hello, world")
//print(paragraph!.asHTML())
//
//paragraph = nil

class HTMLElement {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)>"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

var paragraph: HTMLElement? = HTMLElement(name: "P", text: "hello, world")
print(paragraph!.asHTML())
