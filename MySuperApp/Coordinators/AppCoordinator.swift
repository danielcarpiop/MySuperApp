import UIKit

class AppCoordinator {
    private let window: UIWindow
    private let tabBarCoordinator: TabBarCoordinator
    
    init(window: UIWindow) {
        self.window = window
        self.tabBarCoordinator = TabBarCoordinator()
    }
    
    func start() {
        window.rootViewController = tabBarCoordinator.tabBarController
        window.makeKeyAndVisible()
    }
}

