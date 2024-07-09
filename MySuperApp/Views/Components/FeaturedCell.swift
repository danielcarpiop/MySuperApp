import UIKit

class FeaturedCell: UICollectionViewCell {
    static let identifier = "FeaturedCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let featuredLabel: UILabel = {
        let label = UILabel()
        label.text = "Feature"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addToCartButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "plus.circle")
        configuration.imagePadding = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        configuration.baseForegroundColor = .systemBlue
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        return button
    }()
    
    var addProduct: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addToCartButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addToCartButton.addAnimation()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.black.cgColor
        
        contentView.addSubview(productImageView)
        contentView.addSubview(featuredLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addToCartButton)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            productImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            featuredLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            featuredLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            featuredLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: featuredLabel.bottomAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: addToCartButton.leadingAnchor, constant: -8),
            
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: 45),
            addToCartButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc private func buttonTapped() {
        addProduct?()
        NotificationCenter.default.post(name: .badgetUpdated, object: nil)
    }
    
    func configure(product: Product) {
        productImageView.loadImage(from: product.image)
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
    }
}
