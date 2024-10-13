import Foundation

enum NavArea: String, CaseIterable {
    case navareaI = "Navarea I - UK"
    case navareaIBaltic = "Navarea I - Baltic Sea Sub-area"
    case navareaII = "Navarea II - France"
    case navareaIII = "Navarea III - Spain"
    case navareaIV = "Navarea IV - USA"
    case navareaV = "Navarea V - Brazil"
    case navareaVI = "Navarea VI - Argentina"
    case navareaVII = "Navarea VII - South Africa"
    case navareaVIII = "Navarea VIII - India"
    case navareaIX = "Navarea IX - Pakistan"
    case navareaX = "Navarea X - Australia"
    case navareaXI = "Navarea XI - Japan"
    case navareaXII = "Navarea XII - USA"
    case navareaXIII = "Navarea XIII - Russia"
    case navareaXIV = "Navarea XIV - New Zealand"
    case navareaXV = "Navarea XV - Chile"
    case navareaXVI = "Navarea XVI - Peru"
    case navareaXVII = "Navarea XVII - Canada"
    case navareaXVIII = "Navarea XVIII - Canada"
    case navareaXIX = "Navarea XIX - Norway"
    case navareaXX = "Navarea XX - Russia"
    case navareaXXI = "Navarea XXI - Russia"
   
    static func allAreas() -> [String] {
        return NavArea.allCases.map { $0.rawValue }
    }
}
