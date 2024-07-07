import Foundation
import Combine

protocol ProductService {
    func getProduct() -> AnyPublisher<[Product], MySuperError>
    func getCategories() -> AnyPublisher<[String], MySuperError>
    func getCategory(category: String) -> AnyPublisher<[Product], MySuperError>
}
