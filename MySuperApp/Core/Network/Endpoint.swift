import Foundation

enum Endpoint {
    case product
    case categories
    case category(String)

    var rawValue: String {
        switch self {
        case .product:
            return "/products"
        case .categories:
            return "/products/categories"
        case .category(let category):
            return "/products/categories\(category)"
        }
    }
}
