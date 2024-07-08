import UIKit

class ProductCell: UICollectionViewCell {
    static let identifier = "ProductCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        let button = UIButton()
        let icon = UIImage(systemName: "plus.circle")
        button.setImage(icon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var addProduct: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        addToCartButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.black.cgColor
        
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addToCartButton)
        
        NSLayoutConstraint.activate([
            productImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            priceLabel.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor),
            
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            addToCartButton.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: 24),
            addToCartButton.heightAnchor.constraint(equalToConstant: 24),
            addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
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
