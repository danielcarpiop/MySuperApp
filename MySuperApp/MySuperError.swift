enum MySuperError: Error {
    case badRequest(String)
    case decodingFailed(String)
    case badURL
    case unknownError(String)
    case managedError(String)
    case serverError(Int)
    case networkError(Error)
}
