import Foundation

class URLFactory {
    static let shared = URLFactory()
    
    private var baseURL: String {
        return "https://fakestoreapi.com"
    }
    
    private func url(for endpoint: Endpoint) -> URL {
        let stringURL = baseURL + endpoint.rawValue
        guard let url = URL(string: stringURL) else {
            fatalError("Could not construct URL for Endpoint: \(endpoint)")
        }
        return url
    }
    
    func request(
        for endpoint: Endpoint,
        method: HttpMethod = .get,
        body: [String: Any]? = nil
    ) -> URLRequest {
        let url = url(for: endpoint)
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 60
        )
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let body {
            do {
                let data = try JSONSerialization.data(withJSONObject: body)
                request.httpBody = data
            } catch {
                debugPrint(error)
            }
        }
        return request
    }
}
