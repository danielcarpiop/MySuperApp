import UIKit

class TabBarCoordinator: NSObject {
    var tabBarController: UITabBarController
    var productsViewController: ProductsViewController
    var cartViewController: CartViewController
    
    override init() {
        self.tabBarController = UITabBarController()
        self.productsViewController = ProductsViewController()
        self.cartViewController = CartViewController()
        
        super.init()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        productsViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        cartViewController.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 1)
        
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: productsViewController),
            UINavigationController(rootViewController: cartViewController)
        ]
    }
}
