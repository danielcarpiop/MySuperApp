import UIKit

class TabBarCoordinator: NSObject {
    private var navigationController: UINavigationController
    private var tabBarController = UITabBarController()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        tabBarController.setViewControllers(prepareTabsController(), animated: true)
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .white
        
        navigationController.viewControllers = [tabBarController]
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
