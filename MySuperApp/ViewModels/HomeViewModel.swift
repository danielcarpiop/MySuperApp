import Combine

class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    private var cancellables = Set<AnyCancellable>()
    private let productService: ProductService
    
    init(productService: ProductService) {
        self.productService = productService
    }
    
    func fetchProducts() {
        productService.getProduct()
            .compactMap { [weak self] products in
                self?.determineFeaturedProduct(from: products)
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    debugPrint("Error fetching products: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] products in
                self?.products = products
            })
            .store(in: &cancellables)
    }
    
    func filterCategory(category: String) {
        productService.getCategory(category: category)
            .compactMap { [weak self] products in
                self?.determineFeaturedProduct(from: products)
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    debugPrint("Error fetching products: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] products in
                self?.products = products
            })
            .store(in: &cancellables)
    }
    
    private func determineFeaturedProduct(from products: [Product]) -> [Product] {
        guard !products.isEmpty else { return [] }
        
        let featuredProduct = products.max(by: { ($0.rating.rate * Double($0.rating.count)) < ($1.rating.rate * Double($0.rating.count)) })
        var orderedProducts = products.filter { $0 != featuredProduct }
        
        if let featured = featuredProduct {
            orderedProducts.insert(featured, at: 0)
        }
        
        return orderedProducts
    }
    
    func addProduct(product: Product) {
        CoreDataManager.shared.addCartItem(product: product)
    }
}


