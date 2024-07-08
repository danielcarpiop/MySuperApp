import UIKit

class AppCoordinator {
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let tabCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabCoordinator.start()
    }
}
