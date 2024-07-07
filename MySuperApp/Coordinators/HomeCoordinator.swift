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
    
    func showProductDetail(product: Product) {
        let productDetailViewModel = ProductDetailViewModel(product: product)
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.viewModel = productDetailViewModel
        
        if let sheet = productDetailViewController.sheetPresentationController {
            let customDetent = UISheetPresentationController.Detent.custom { context in
                return context.maximumDetentValue * 0.70
            }
            sheet.detents = [customDetent, .large()]
            sheet.selectedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 15
        }
        
        productDetailViewController.modalPresentationStyle = .pageSheet
        navigationController.present(productDetailViewController, animated: true, completion: nil)
    }
}
