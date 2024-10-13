import Foundation
import SwiftSoup

class Parser: NSObject {
    public func parseHTML(_ html: String) -> [Warning] {
        var warnings: [Warning] = []
        var uniqueWarningsSet: Set<String> = []
        let wrappedHTML = "<table>\(html)</table>"

        do {
            let document = try SwiftSoup.parse(wrappedHTML)
            let rows = try document.select("tr")
            for row in rows {
                let checkboxes = try row.select("input[type=checkbox]")
                guard let checkbox = checkboxes.first() else { continue }
                let value = try checkbox.attr("value")
                let hiddenElement = checkbox.nextSibling() as? Element
                let pTitle = hiddenElement != nil ? try hiddenElement!.val() : ""

                let yearString = try row.select("td[id^=years_]").first()?.text() ?? ""
                let numberString = try row.select("td[id^=numbers_]").first()?.text() ?? ""
                var messageContent = try row.select("td[id^=des_]").first()?.text() ?? ""
                messageContent = messageContent.components(separatedBy: .newlines).first ?? messageContent
                guard !yearString.isEmpty, !numberString.isEmpty, !messageContent.isEmpty else {
                    continue
                }
                let warning = Warning(value: value, title: pTitle, year: yearString, number: numberString, message: messageContent)
                let uniqueKey = "\(warning.value)-\(warning.year)-\(warning.number)-\(warning.message)"
                if !uniqueWarningsSet.contains(uniqueKey) {
                    uniqueWarningsSet.insert(uniqueKey)
                    warnings.append(warning)
                }
            }
        } catch {
            print("Error parsing HTML: \(error)")
        }

        return warnings
    }
}
