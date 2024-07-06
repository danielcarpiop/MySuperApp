import Foundation
import Combine

protocol ProductService {
    func getProduct() -> AnyPublisher<[Product], MySuperError>
}
