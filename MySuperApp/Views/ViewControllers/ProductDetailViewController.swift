import UIKit

class ProductDetailViewController: UIViewController {
    var viewModel: ProductDetailViewModel?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = UIImage(systemName: "plus.circle")
        button.setImage(iconImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = UIImage(systemName: "xmark.circle")
        button.setImage(iconImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    private let bottomSheetIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindViewModel()
        updatePreferredContentSize()
        
        dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePreferredContentSize()
    }

    private func updatePreferredContentSize() {
        let targetSize = CGSize(width: view.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let size = view.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        preferredContentSize = CGSize(width: size.width, height: size.height + 100)
    }

    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(starsStackView)
        view.addSubview(addButton)
        view.addSubview(dismissButton)
        view.addSubview(bottomSheetIndicator)
        
        NSLayoutConstraint.activate([
            bottomSheetIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            bottomSheetIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomSheetIndicator.widthAnchor.constraint(equalToConstant: 40),
            bottomSheetIndicator.heightAnchor.constraint(equalToConstant: 5),
            
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            starsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            starsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20)
        ])
        
        for _ in 0..<5 {
            let starImageView = UIImageView()
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.contentMode = .scaleAspectFit
            starImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
            starImageView.tintColor = .black
            starsStackView.addArrangedSubview(starImageView)
        }
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.product.title
        priceLabel.text = "$\(viewModel.product.price)"
        descriptionLabel.text = viewModel.product.description
        if let url = URL(string: viewModel.product.image) {
            loadImage(from: url, into: imageView)
        }
        updateStars(rating: viewModel.product.rating)
    }
    
    private func updateStars(rating: Rating) {
        for (index, starImageView) in starsStackView.arrangedSubviews.enumerated() {
            if let starImageView = starImageView as? UIImageView {
                starImageView.image = index < Int(rating.rate) ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            }
        }
    }
    
    private func loadImage(from url: URL, into imageView: UIImageView) {
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addToCart() {
           viewModel?.addToCart()
       }
}
