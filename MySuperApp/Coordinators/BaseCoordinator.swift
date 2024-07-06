import UIKit

class HomeCoordinator {
    private let navigationController: UINavigationController
    private let productService: ProductAPI
    private var tabBarCoordinator: TabBarCoordinator?

    init(navigationController: UINavigationController, productService: ProductAPI) {
        self.navigationController = navigationController
        self.productService = productService
    }

    func start() {
        let homeViewModel = HomeViewModel(productService: productService)
        let homeViewController = HomeViewController()
        homeViewController.viewModel = homeViewModel
        homeViewController.coordinator = self

        tabBarCoordinator = TabBarCoordinator(homeViewController: homeViewController, cartViewController: CartViewController())

        if let tabBarCoordinator = tabBarCoordinator {
            navigationController.setViewControllers([tabBarCoordinator.tabBarController], animated: false)
        }
    }

    func showCategories() {
        let categoriesViewModel = CategoriesViewModel(productService: productService)
        let categoriesViewController = CategoriesViewController()
        categoriesViewController.viewModel = categoriesViewModel
        navigationController.pushViewController(categoriesViewController, animated: true)
    }
}
