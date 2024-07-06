import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "My Super App"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .left
        titleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -16
        
        navigationItem.leftBarButtonItems = [negativeSpacer, leftItem]
        
        let dotsCircle = UIButton(type: .custom)
        let iconImage = UIImage(systemName: "ellipsis.circle")?.withRenderingMode(.alwaysOriginal)
        dotsCircle.setImage(iconImage, for: .normal)
        dotsCircle.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        dotsCircle.imageView?.contentMode = .scaleAspectFit
        dotsCircle.contentVerticalAlignment = .fill
        dotsCircle.contentHorizontalAlignment = .fill
        
        dotsCircle.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        
        let dotsCircleButtomItem = UIBarButtonItem(customView: dotsCircle)
        navigationItem.rightBarButtonItem = dotsCircleButtomItem
    }
    
    @objc private func cartButtonTapped() {
    }
}

