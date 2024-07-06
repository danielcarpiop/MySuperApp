import UIKit

class AppCoordinator {
    private let window: UIWindow
    private var tabBarCoordinator: TabBarCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let productService = ProductAPI()
        let homeViewModel = HomeViewModel(productService: productService)
        let cartViewController = CartViewController()

        tabBarCoordinator = TabBarCoordinator(homeViewModel: homeViewModel, cartViewController: cartViewController)

        if let tabBarCoordinator = tabBarCoordinator {
            window.rootViewController = tabBarCoordinator.tabBarController
            window.makeKeyAndVisible()
        }
    }
}

