import UIKit

class TabBarViewModel: ObservableObject {
    
    func updateTotal() -> Int16 {
        let cartItems = CoreDataManager.shared.fetchCartItems()
        let _ = cartItems.map { cartItem in
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
        return cartItems.compactMap { $0.quantity }.reduce(0,+)
    }
}
