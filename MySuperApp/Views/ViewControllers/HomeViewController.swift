import UIKit
import Combine

protocol HomeVCDelegate: AnyObject {
    func goToProductCategories()
    func showProductDetail(product: Product)
}

class HomeViewController: UIViewController {
    var delegate: HomeVCDelegate?
    private var collectionView: UICollectionView?
    var viewModel: HomeViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    private let customNavigationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Super App"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dotsCircle: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "ellipsis.circle")
        configuration.imagePadding = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        configuration.baseForegroundColor = .systemBlue

        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCustomNavigationBar()
        setupCollectionView()
        bindViewModel()
        
        viewModel?.fetchProducts()
        
        dotsCircle.addTarget(self, action: #selector(viewCategories), for: .touchUpInside)
    }
    
    private func setupCustomNavigationBar() {
        view.addSubview(customNavigationBar)
        customNavigationBar.addSubview(titleLabel)
        customNavigationBar.addSubview(dotsCircle)
        
        NSLayoutConstraint.activate([
            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerYAnchor.constraint(equalTo: customNavigationBar.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: customNavigationBar.leadingAnchor, constant: 16),
            
            dotsCircle.centerYAnchor.constraint(equalTo: customNavigationBar.centerYAnchor),
                   dotsCircle.trailingAnchor.constraint(equalTo: customNavigationBar.trailingAnchor, constant: -16),
                   dotsCircle.widthAnchor.constraint(equalToConstant: 35),
                   dotsCircle.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView?.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.identifier)
        
        if let collectionView = collectionView {
            view.addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    private func bindViewModel() {
        viewModel?.$products
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.collectionView?.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let featuredItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180))
            let featuredItem = NSCollectionLayoutItem(layoutSize: featuredItemSize)
            
            let normalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(150))
            let normalItem = NSCollectionLayoutItem(layoutSize: normalItemSize)
            
            let pairGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
            let pairGroup = NSCollectionLayoutGroup.horizontal(layoutSize: pairGroupSize, subitems: [normalItem, normalItem])
            pairGroup.interItemSpacing = .fixed(10)
            
            let section: NSCollectionLayoutSection
            if sectionIndex == 0 {
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [featuredItem])
                section = NSCollectionLayoutSection(group: group)
            } else {
                section = NSCollectionLayoutSection(group: pairGroup)
            }
            
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20)
            
            return section
        }
        
        return layout
    }
    
    @objc private func viewCategories() {
        delegate?.goToProductCategories()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return (viewModel?.products.count ?? 1) - 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCell.identifier, for: indexPath) as? FeaturedCell else {
                return UICollectionViewCell()
            }
            if let product = viewModel?.products.first {
                cell.configure(product: product)
                cell.addProduct = { [weak self] in
                    self?.viewModel?.addProduct(product: product)
                }
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
                return UICollectionViewCell()
            }
            if let product = viewModel?.products[indexPath.item + 1] {
                cell.configure(product: product)
                cell.addProduct = { [weak self] in
                    self?.viewModel?.addProduct(product: product)
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedProduct: Product = {
            if indexPath.section == 0 {
                return viewModel?.products.first
            } else {
                return viewModel?.products[indexPath.item + 1]
            }
        }() else {
            return
        }
        delegate?.showProductDetail(product: selectedProduct)
    }
}

extension HomeViewController {
    func filterCategory(category: CategoriesEnum) {
        switch category {
        case .all:
            viewModel?.fetchProducts()
        case .category(let name):
            viewModel?.filterCategory(category: name)
        }
       
    }
}
