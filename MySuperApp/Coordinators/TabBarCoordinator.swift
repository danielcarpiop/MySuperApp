import UIKit

class TabBarCoordinator: NSObject {
    var tabBarController: UITabBarController

    init(homeViewController: HomeViewController, cartViewController: CartViewController) {
        self.tabBarController = UITabBarController()

        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        cartViewController.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 1)

        tabBarController.viewControllers = [homeViewController, cartViewController]
    }
}
