import UIKit
import Combine

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
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remove", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let countControlView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var removeSubject = PassthroughSubject<Void, Never>()
    var incrementSubject = PassthroughSubject<Void, Never>()
    var decrementSubject = PassthroughSubject<Void, Never>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addActions()
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(removeButton)
        contentView.addSubview(countControlView)
        countControlView.addSubview(decrementButton)
        countControlView.addSubview(quantityLabel)
        countControlView.addSubview(incrementButton)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            removeButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 12),
            removeButton.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
            removeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            removeButton.heightAnchor.constraint(equalToConstant: 30),
            
            countControlView.topAnchor.constraint(equalTo: removeButton.bottomAnchor, constant: 20),
            countControlView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            countControlView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            countControlView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            decrementButton.leadingAnchor.constraint(equalTo: countControlView.leadingAnchor),
            decrementButton.centerYAnchor.constraint(equalTo: countControlView.centerYAnchor),
            decrementButton.widthAnchor.constraint(equalToConstant: 30),
            decrementButton.heightAnchor.constraint(equalToConstant: 30),
            
            quantityLabel.centerYAnchor.constraint(equalTo: countControlView.centerYAnchor),
            quantityLabel.leadingAnchor.constraint(equalTo: decrementButton.trailingAnchor, constant: 8),
        
            incrementButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 8),
            incrementButton.centerYAnchor.constraint(equalTo: countControlView.centerYAnchor),
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
        removeSubject.send(())
    }
    
    @objc private func incrementButtonTapped() {
        incrementSubject.send(())
    }
    
    @objc private func decrementButtonTapped() {
        decrementSubject.send(())
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
//        titleLabel.text = "product.title"
//        priceLabel.text = "$2.500CLP"
//        quantityLabel.text = "1"
        if let url = URL(string: product.image) {
            loadImage(from: url, into: productImageView)
        }
    }
    
    private func loadImage(from url: URL, into imageView: UIImageView) {
       
    }
}
