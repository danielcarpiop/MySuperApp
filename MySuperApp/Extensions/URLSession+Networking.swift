import Combine
import Foundation

extension URLSession {
    func execute<T: Decodable>(
        _ request: URLRequest,
        with decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<T, MySuperError> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    return data
                case 400:
                    throw MySuperError.badRequest("Bad Request")
                case 500...599:
                    throw MySuperError.serverError(httpResponse.statusCode)
                default:
                    throw MySuperError.unknownError("Unexpected HTTP status code: \(httpResponse.statusCode)")
                }
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error -> MySuperError in
                if let urlError = error as? URLError {
                    return MySuperError.networkError(urlError)
                } else if let mySuperError = error as? MySuperError {
                    return mySuperError
                } else {
                    return MySuperError.unknownError(error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
}
