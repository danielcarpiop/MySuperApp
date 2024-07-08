import Combine
import Foundation
import CoreData

class CartViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var totalAmount: String = "0.00"
    var cartItems: [CartItem] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let numberFormatter: NumberFormatter
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        fetchCartItems()
    }
    
    func fetchCartItems() {
        cartItems = CoreDataManager.shared.fetchCartItems()
        cartItems.removeAll(where: { $0.title == nil })
        cartItems = cartItems.sorted { $0.title ?? "" < $1.title ?? "" }
        self.products = cartItems.map { cartItem in
            return Product(
                id: Int(cartItem.itemId),
                title: cartItem.title ?? "",
                price: cartItem.price,
                description: cartItem.itemDescription ?? "",
                category: cartItem.category ?? "",
                image: cartItem.image ?? "",
                rating: Rating(rate: cartItem.rate, count: Int(cartItem.count)),
                quantity: Int(cartItem.quantity)
            )
        }
        recalculateTotalAmount()
    }
    
    func addProduct(product: Product, isIncrement: Bool = true) {
        CoreDataManager.shared.addCartItem(product: product, isIncrement: isIncrement)
        fetchCartItems()
    }
    
    func removeProduct(at index: Int) {
        guard index < cartItems.count else {
            return
        }
        CoreDataManager.shared.removeCartItem(cartItem: cartItems[index])
        fetchCartItems()
    }
    
    private func recalculateTotalAmount() {
        let total = products.reduce(0.0) { $0 + ($1.price * Double($1.quantity ?? 0)) }
        totalAmount = numberFormatter.string(from: NSNumber(value: total)) ?? "0.00"
    }
}
