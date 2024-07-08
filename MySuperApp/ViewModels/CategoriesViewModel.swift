import Foundation
import Combine

class CategoriesViewModel {
    private let productService: ProductAPI
    @Published var categories: [CategoriesEnum] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(productService: ProductAPI) {
        self.productService = productService
    }
    
    func fetchCategories() {
        productService.getCategories()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    debugPrint("Error fetching categories: \(error)")
                }
            }, receiveValue: { [weak self] categories in
                var newCategories = [CategoriesEnum.all]
                categories.forEach {
                    newCategories.append(CategoriesEnum.category(name: $0))
                }
                self?.categories = newCategories
            })
            .store(in: &cancellables)
    }
}
