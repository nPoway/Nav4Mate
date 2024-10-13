import Foundation

class NetworkManager {
    private var id: Int
    private var title: String
    
    init(navArea: NavArea) {
            switch navArea {
            case .navareaI:
                self.id = 1
                self.title = "Navarea+I"
            case .navareaIBaltic:
                self.id = 34
                self.title = "Navarea+I"
            case .navareaII:
                self.id = 2
                self.title = "Navarea+II"
            case .navareaIII:
                self.id = 3
                self.title = "Navarea+III"
            case .navareaIV:
                self.id = 4
                self.title = "Navarea+IV"
            case .navareaV:
                self.id = 5
                self.title = "Navarea+V"
            case .navareaVI:
                self.id = 6
                self.title = "Navarea+VI"
            case .navareaVII:
                self.id = 7
                self.title = "Navarea+VII"
            case .navareaVIII:
                self.id = 8
                self.title = "Navarea+VIII"
            case .navareaIX:
                self.id = 9
                self.title = "Navarea+IX"
            case .navareaX:
                self.id = 10
                self.title = "Navarea+X"
            case .navareaXI:
                self.id = 11
                self.title = "Navarea+XI"
            case .navareaXII:
                self.id = 12
                self.title = "Navarea+XII"
            case .navareaXIII:
                self.id = 13
                self.title = "Navarea+XIII"
            case .navareaXIV:
                self.id = 14
                self.title = "Navarea+XIV"
            case .navareaXV:
                self.id = 15
                self.title = "Navarea+XV"
            case .navareaXVI:
                self.id = 16
                self.title = "Navarea+XVI"
            case .navareaXVII:
                self.id = 17
                self.title = "Navarea+XVII"
            case .navareaXVIII:
                self.id = 18
                self.title = "Navarea+XVIII"
            case .navareaXIX:
                self.id = 19
                self.title = "Navarea+XIX"
            case .navareaXX:
                self.id = 20
                self.title = "Navarea+XX"
            case .navareaXXI:
                self.id = 21
                self.title = "Navarea+XXI"
            }
        
    }
    
    func fetchData(completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "https://www.navwarnings.com/wp-admin/admin-ajax.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json, text/javascript, */*; q=0.01", forHTTPHeaderField: "accept")
        request.addValue("ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7", forHTTPHeaderField: "accept-language")
        request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "content-type")
        request.addValue("\"Google Chrome\";v=\"129\", \"Not=A?Brand\";v=\"8\", \"Chromium\";v=\"129\"", forHTTPHeaderField: "sec-ch-ua")
        request.addValue("?0", forHTTPHeaderField: "sec-ch-ua-mobile")
        request.addValue("\"macOS\"", forHTTPHeaderField: "sec-ch-ua-platform")
        request.addValue("empty", forHTTPHeaderField: "sec-fetch-dest")
        request.addValue("cors", forHTTPHeaderField: "sec-fetch-mode")
        request.addValue("same-origin", forHTTPHeaderField: "sec-fetch-site")
        request.addValue("XMLHttpRequest", forHTTPHeaderField: "x-requested-with")
        request.addValue("https://www.navwarnings.com/subscription/", forHTTPHeaderField: "Referer")

        let postData = "action=get_sub_row&row_id=\(id)&parent_id=\(id)&p_title=\(title)".data(using: .utf8)
        request.httpBody = postData

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No data received.")
                return
            }

            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let htmlValue = json["html"] as? String {
                    completion(.success(htmlValue))
                } else {
                    print("Failed to parse JSON or find 'html' key.")
                    completion(.failure(NSError(domain: "NetworkError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON or find 'html' key."])))
                }
            } catch {
                print("JSON Parsing Error: \(error)")
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
