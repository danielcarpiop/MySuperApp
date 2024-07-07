import Foundation
import Combine

class CategoriesViewModel {
    private let productService: ProductAPI
    @Published var categories: [String] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(productService: ProductAPI) {
        self.productService = productService
    }
    
    func fetchCategories() {
        productService.getCategories()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching categories: \(error)")
                }
            }, receiveValue: { [weak self] categories in
                self?.categories = categories
            })
            .store(in: &cancellables)
    }
}
