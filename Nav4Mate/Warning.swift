import Foundation

class Warning {
    var value: String
    var title: String
    var year: String
    var number: String
    var message: String

    init(value: String, title: String, year: String, number: String, message: String) {
        self.value = value
        self.title = title
        self.year = year
        self.number = number
        self.message = message
    }
}
