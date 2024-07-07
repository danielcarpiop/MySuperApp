import UIKit

class CartItemCell: UITableViewCell {
    static let identifier = "CartItemCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Quitar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let decrementButton: UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(systemName: "minus.circle.fill")
        button.setImage(icon, for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let incrementButton: UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(systemName: "plus.circle.fill")
        button.setImage(icon, for: .normal)
        button.tintColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var onRemove: (() -> Void)?
    var onIncrement: (() -> Void)?
    var onDecrement: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(removeButton)
        contentView.addSubview(decrementButton)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(incrementButton)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor, constant: -8),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor, constant: -8),
            
            removeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            removeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            removeButton.widthAnchor.constraint(equalToConstant: 80),
            removeButton.heightAnchor.constraint(equalToConstant: 30),
            
            decrementButton.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            decrementButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            decrementButton.widthAnchor.constraint(equalToConstant: 30),
            decrementButton.heightAnchor.constraint(equalToConstant: 30),
            
            quantityLabel.centerYAnchor.constraint(equalTo: decrementButton.centerYAnchor),
            quantityLabel.leadingAnchor.constraint(equalTo: decrementButton.trailingAnchor, constant: 8),
            
            incrementButton.centerYAnchor.constraint(equalTo: decrementButton.centerYAnchor),
            incrementButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 8),
            incrementButton.widthAnchor.constraint(equalToConstant: 30),
            incrementButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func addActions() {
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        incrementButton.addTarget(self, action: #selector(incrementButtonTapped), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decrementButtonTapped), for: .touchUpInside)
    }
    
    @objc private func removeButtonTapped() {
        onRemove?()
    }
    
    @objc private func incrementButtonTapped() {
        onIncrement?()
    }
    
    @objc private func decrementButtonTapped() {
        onDecrement?()
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
        quantityLabel.text = "\(product.quantity)"
        if let url = URL(string: product.image) {
            loadImage(from: url, into: productImageView)
        }
    }
    
    private func loadImage(from url: URL, into imageView: UIImageView) {
    }
}
