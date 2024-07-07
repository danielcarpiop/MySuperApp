import UIKit

protocol CategoriesCoordinatorDelegate: AnyObject {
    func filterCategory(category: String)
}

class CategoriesCoordinator {
    var delegate: CategoriesCoordinatorDelegate?
    private let navigationController: UINavigationController
    private var categoriesViewController: CategoriesViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.categoriesViewController = CategoriesViewController()
        categoriesViewController.delegate = self
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

extension CategoriesCoordinator: CategoryVCDelegate {
    func filterCategory(category: String) {
        delegate?.filterCategory(category: category)
    }
}
