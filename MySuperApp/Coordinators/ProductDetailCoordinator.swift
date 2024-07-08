import UIKit

class ProductDetailCoordinator {
    private let navigationController: UINavigationController
    private var viewController: ProductDetailViewController
    private var product: Product?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewController = ProductDetailViewController()
        guard let product else { return }
        let viewModel = ProductDetailViewModel(product: product)
        viewController.viewModel = viewModel
    }
    
    func start() {
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .coverVertical
        navigationController.present(viewController, animated: true)
    }
}
