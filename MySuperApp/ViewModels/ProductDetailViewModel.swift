import Foundation

import Combine
import Foundation

class ProductDetailViewModel: ObservableObject {
    @Published var product: Product
    private var cancellables = Set<AnyCancellable>()
    
    init(product: Product) {
        self.product = product
    }
    
    func addToCart() {
        CoreDataManager.shared.addCartItem(product: product)
    }
}
