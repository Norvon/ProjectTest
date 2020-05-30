//// 初始化
//struct Fahrenheit {
//    var temperature = 32.0
//}
//
//var f = Fahrenheit()
//print("The default temperature is \(f.temperature)° Fahrenheit")
//
//struct Celsius {
//    var temperatureInCelsius: Double
//    init(fromFahrenheit fahrenheit: Double) {
//        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
//    }
//    init(fromKelvin kelvin: Double) {
//        temperatureInCelsius = kelvin - 273.15
//    }
//}
//
//let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
//let freezingPointOfWater = Celsius(fromKelvin: 273.15)
//
//struct Color {
//    let red, green, blue: Double
//    init(red: Double, green: Double, blue: Double) {
//        self.red = red
//        self.green = green
//        self.blue = blue
//    }
//
//    init(white: Double) {
//        red = white
//        green = white
//        blue = white
//    }
//}
//
//let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
//let halfGray = Color(white: 0.5)
////let veryGreen = Color(0.0, 1.0, 0.0)
//
//struct Celsius {
//    var temperatureInCelsius: Double
//    init(fromFahrenheit fahrenheit: Double) {
//        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
//    }
//    init(fromKelvin kelvin: Double) {
//        temperatureInCelsius = kelvin - 273.15
//    }
//    init(_ celsius: Double) {
//        temperatureInCelsius = celsius
//    }
//}
//let bodyTemperature = Celsius(37.0)
//
//// 可选属性类型
//class SurveyQuestion {
//    var text: String
//    var response: String?
//    init(text: String) {
//        self.text = text
//    }
//    func ask() {
//        print(text)
//    }
//}
//
//let cheeseQuestion = SurveyQuestion(text: "Do you lick cheese?")
//cheeseQuestion.ask()
//cheeseQuestion.response = "Yes, I do like cheese."

// 在初始化中分配常量属性
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets. (But not with cheese.)"

