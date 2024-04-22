enum NetworkError: Error {
    case invalidURL, networkError(Error), serializationError, invalidResponse, invalidData
}

class NetworkService {
    static let shared = NetworkService()

    private init() { print("NetworkService called ") }

    func getData(baseURL: String, apiKey: String? = nil, endpoint: String, id: Int, success: @escaping ([String: Any]) -> Void, failure: @escaping (NetworkError) -> Void) {
        print("get data")
        let urlString = baseURL + "/\(endpoint)/\(id)"
        guard let url = URL(string: urlString) else {
            failure(.invalidURL)
            return
        }

        var request = URLRequest(url: url)
        if let apiKey = apiKey {
            request.setValue(apiKey, forHTTPHeaderField: "API-Key")
        }

        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            print("session started")
            if let error = error {
                failure(.networkError(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200 ... 299).contains(httpResponse.statusCode)
            else {
                failure(.invalidResponse)
                return
            }

            guard let data = data,
                  let responseData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            else {
                failure(.invalidData)
                return
            }
            print("session ended")
            print(responseData)
            success(responseData)
        }

        task.resume()
    }

    func postData(baseURL: String, apiKey: String? = nil, endpoint: String, id: Int, data: [String: Any], success: @escaping (String) -> Void, failure: @escaping (NetworkError) -> Void) {
        let urlString = baseURL + "/\(endpoint)/\(id)"
        guard let url = URL(string: urlString) else {
            failure(.invalidURL)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        if let apiKey = apiKey {
            request.setValue(apiKey, forHTTPHeaderField: "API-Key")
        }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            failure(.serializationError)
            return
        }

        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                failure(.networkError(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200 ... 299).contains(httpResponse.statusCode)
            else {
                failure(.invalidResponse)
                return
            }

            guard let data = data,
                  let responseData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            else {
                failure(.invalidData)
                return
            }

            if let status = responseData["status"] as? String {
                success(status)
            } else {
                failure(.invalidData)
            }
        }

        task.resume()
    }
}
