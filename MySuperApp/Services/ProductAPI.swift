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
}
