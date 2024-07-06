import Foundation
import Combine

class ProductAPI: ProductService {
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    func getProduct() -> AnyPublisher<[Product], MySuperError> {
        let request = URLFactory.shared.request(for: .product)
        return URLSession.shared.execute(request, with: decoder)
    }
    
    func getCategories() -> AnyPublisher<[Category], MySuperError> {
        let request = URLFactory.shared.request(for: .categories)
        return URLSession.shared.execute(request, with: decoder)
    }
}
