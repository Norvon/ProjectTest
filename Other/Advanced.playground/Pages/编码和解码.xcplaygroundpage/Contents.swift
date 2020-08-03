//: [Previous](@previous)

import Foundation

// Encodable
// Decodable
// public typealias Codable = Decodable & Encodable

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

struct Placemark: Codable {
    var name: String
    var coordinate: Coordinate
}

let places = [
    Placemark(name: "Berlin", coordinate: Coordinate(latitude: 52, longitude: 13)),
    Placemark(name: "Cape Town", coordinate: Coordinate(latitude: -34, longitude: 18))
]

do {
    let encoder = JSONEncoder()
    let jsonData = try encoder.encode(places)
    let jsonSting = String(decoding: jsonData, as: UTF8.self)
    print(jsonSting)
} catch {
    print(error.localizedDescription)
}

// Decoding
do {
    
    let encoder = JSONEncoder()
    let jsonData = try encoder.encode(places)
    
    let decoder = JSONDecoder()
    let decoded = try decoder.decode([Placemark].self, from: jsonData)
    type(of: decoded)
} catch {
    print(error.localizedDescription)
}

// 容器
// 键容器 (Keyed Container) 用于编码键值对。
// 无键容器 (Unkeyed Container) 用于编码一系列值，但不需要对应的键，可以将它想像成保存编码结果的数组。
// 单值容器对单一值进行编码。
//: [Next](@next)
