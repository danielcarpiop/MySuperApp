import UIKit

class TabBarCoordinator: NSObject {
    var tabBarController: UITabBarController
    var homeViewController: HomeViewController
    var cartViewController: CartViewController

    init(homeViewModel: HomeViewModel, cartViewController: CartViewController) {
        self.tabBarController = UITabBarController()
        self.homeViewController = HomeViewController()
        self.homeViewController.viewModel = homeViewModel
        self.cartViewController = cartViewController

        super.init()

        setupTabBar()
    }

    private func setupTabBar() {
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        cartViewController.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 1)

        tabBarController.viewControllers = [
            UINavigationController(rootViewController: homeViewController),
            UINavigationController(rootViewController: cartViewController)
        ]
    }
}

