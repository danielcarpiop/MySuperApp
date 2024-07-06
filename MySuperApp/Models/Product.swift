import Foundation

struct Product: Codable, Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.price == rhs.price &&
        lhs.description == rhs.description &&
        lhs.category == rhs.category &&
        lhs.image == rhs.image &&
        lhs.rating == rhs.rating
    }
    
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

struct Rating: Codable, Equatable {
    let rate: Double
    let count: Int
}
