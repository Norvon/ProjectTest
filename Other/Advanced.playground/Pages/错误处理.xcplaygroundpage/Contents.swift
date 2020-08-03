//: [Previous](@previous)

import Foundation
// 简介 可传递 文档 安全 通用

// 可以忽略细节的错误
// 需要提高详细信息的错误
// 非预期错误

enum Result<Success, Failure: Error> {
    case Success(Success)
    case failur(Failure)
}

enum FileError: Error {
    case fileDoesNotExitst
    case noPermission
}

func contents(ofFile filname: String) -> Result<String, FileError> {
    guard filname.split(separator: ".").last == "txt" else {
        return .failur(.fileDoesNotExitst)
    }
    return .Success("成功")
}

let result = contents(ofFile: "input.txt")
switch result {
case let .Success(contents):
    print(contents)
case let .failur(error):
    switch error {
    case .fileDoesNotExitst:
        print("File not found")
    case .noPermission:
        print("No permission")
    }
}

do {
    let result = try contents(ofFile: "input.txt1")
    print("result = \(result)")
} catch FileError.fileDoesNotExitst {
    print("File not found")
} catch {
    print("error = \(error)")
}

//extension Result where Failure == Swift.Error {
//    init(catching body: () throws -> Success) {
//        do {
//            self = .Success(try body())
//        } catch {
//            self = .failur(error)
//        }
//    }
//}

//let encoder = JSONEncoder()
//let encodingResult = Result { try encoder.encode([1, 2]) }
//type(of: encodingResult)

//func contents(ofFile filename: String) throws -> String {
//    let file = open(filename, O_RDONLY)
//    defer {
//        close(file)
//    }
//    return try load(file: file)
//}

var counter = 0
func increment() -> Int {
    defer {
        counter += 1
    }
    return counter
}

increment()
counter

//: [Next](@next)
