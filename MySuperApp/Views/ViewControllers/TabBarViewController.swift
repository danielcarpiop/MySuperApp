import UIKit

class TabBarViewController: UITabBarController {
    var viewModel: TabBarViewModel?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBadge), name: .badgetUpdated, object: nil)
        updateBadge()
    }
    
    @objc func updateBadge() {
        guard
            let total = viewModel?.updateTotal(),
            let viewController = viewControllers?.first(where: { $0.tabBarItem.tag == 1 } )
        else { return }
        viewController.tabBarItem.badgeValue = String(describing: total)
    }
}

