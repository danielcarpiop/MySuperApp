import UIKit

class CategoriesCoordinator {
    private let navigationController: UINavigationController
    private var categoriesViewController: CategoriesViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.categoriesViewController = CategoriesViewController()
        let productService = ProductAPI()
        let categoriesViewModel = CategoriesViewModel(productService: productService)
        categoriesViewController.viewModel = categoriesViewModel
    }
    
    func start() {
        categoriesViewController.modalPresentationStyle = .overFullScreen
        categoriesViewController.modalTransitionStyle = .coverVertical
        navigationController.present(categoriesViewController, animated: true)
    }
}
