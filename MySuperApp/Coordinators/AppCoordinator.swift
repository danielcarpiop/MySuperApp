import UIKit

class AppCoordinator {
    private let window: UIWindow
    private var homeCoordinator: HomeCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let productService = ProductAPI()
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        
        homeCoordinator = HomeCoordinator(navigationController: navigationController, productService: productService)
        homeCoordinator?.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
