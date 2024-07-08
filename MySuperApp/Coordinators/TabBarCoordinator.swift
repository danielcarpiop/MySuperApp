import UIKit

class TabBarCoordinator: NSObject {
    private var navigationController: UINavigationController
    private var tabBarViewController: TabBarViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarViewController = TabBarViewController()
        self.tabBarViewController.viewModel = TabBarViewModel()
    }
    
    func start() {
        tabBarViewController.setViewControllers(prepareTabsController(), animated: true)
        tabBarViewController.tabBar.isTranslucent = false
        tabBarViewController.tabBar.backgroundColor = .white
        
        navigationController.viewControllers = [tabBarViewController]
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    private func prepareTabsController() -> [UINavigationController] {
        let homeNavController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavController)
        homeCoordinator.homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        homeCoordinator.start()
        
        let cartNavController = UINavigationController()
        let cartCoordinator = CartCoordinator(navigationController: cartNavController)
        cartCoordinator.cartViewController.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 1)
        cartCoordinator.start()
        
        return [homeNavController, cartNavController]
    }
}
