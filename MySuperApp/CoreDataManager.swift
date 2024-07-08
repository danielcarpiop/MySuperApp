import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()

    private let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "CartModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchCartItems() -> [CartItem] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            debugPrint("Failed to fetch CartItems: \(error)")
            return []
        }
    }

    func addCartItem(product: Product, isIncrement: Bool = true) {
        let context = persistentContainer.viewContext
        let cartItem = CartItem(context: context)
        if let item = fetchCartItems().first(where: { $0.title == product.title }) {
            if isIncrement {
                updateCartItem(cartItem: item, quantity: item.quantity + 1)
            } else if item.quantity > 1 {
                updateCartItem(cartItem: item, quantity: item.quantity - 1)
            }
        } else {
            cartItem.itemId = Int16(product.id)
            cartItem.title = product.title
            cartItem.price = product.price
            cartItem.quantity = 1
            cartItem.itemDescription = product.description
            cartItem.category = product.category
            cartItem.image = product.image
            cartItem.rate = product.rating.rate
            cartItem.count = Int16(product.rating.count)
            saveContext()
        }
    }

    func removeCartItem(cartItem: CartItem) {
        let context = persistentContainer.viewContext
        context.delete(cartItem)
        saveContext()
    }

    func updateCartItem(cartItem: CartItem, quantity: Int16) {
        cartItem.quantity = quantity
        saveContext()
    }
}
