import Foundation

enum Endpoint {
    case product

    var rawValue: String {
        switch self {
        case .product:
            return "/products"
        }
    }
}
