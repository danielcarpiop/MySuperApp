import UIKit

class HomeCoordinator {
    private let navigationController: UINavigationController
    private(set) var homeViewController: HomeViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let productService = ProductAPI()
        let homeViewModel = HomeViewModel(productService: productService)
        homeViewController = HomeViewController()
        homeViewController.coordinator = self
        homeViewController.viewModel = homeViewModel
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func showCategories() {
       let categoriesCoordinator = CategoriesCoordinator(navigationController: navigationController)
        categoriesCoordinator.start()
    }
}
