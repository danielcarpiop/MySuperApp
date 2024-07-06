import UIKit
import SwiftUI

class FeaturedProductCell: UICollectionViewCell {
    static let identifier = "FeaturedProductCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let featuredLabel: UILabel = {
        let label = UILabel()
        label.text = "Destacado"
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
        let button = UIButton()
        let icon = UIImage(systemName: "plus.circle")
        button.setImage(icon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            featuredLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            featuredLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            featuredLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: featuredLabel.bottomAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: addToCartButton.leadingAnchor, constant: -8),
            
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            addToCartButton.widthAnchor.constraint(equalToConstant: 24),
            addToCartButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(product: Product) {
        productImageView.image = UIImage(named: product.image)
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
    }
}
