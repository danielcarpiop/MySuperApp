import UIKit

class CartCoordinator {
    private let navigationController: UINavigationController
    private(set) var cartViewController: CartViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let viewModel = CartViewModel()
        cartViewController = CartViewController(viewModel: viewModel)
    }
    
    func start() {
        navigationController.pushViewController(cartViewController, animated: true)
    }
}
