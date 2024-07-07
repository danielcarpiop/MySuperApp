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
    let category: String
    let image: String
    let rating: Rating
    var quantity: Int?
}

struct Rating: Codable, Equatable {
    let rate: Double
    let count: Int
}
