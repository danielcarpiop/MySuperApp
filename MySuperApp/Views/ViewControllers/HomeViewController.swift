import UIKit
import Combine

class HomeViewController: BaseViewController {
    private var collectionView: UICollectionView?
    var viewModel: HomeViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        bindViewModel()
        
        viewModel?.fetchProducts()
    }
    
    private func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView?.register(FeaturedProductCell.self, forCellWithReuseIdentifier: FeaturedProductCell.identifier)
        
        if let collectionView = collectionView {
            view.addSubview(collectionView)
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
            
            let featuredItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
            let featuredItem = NSCollectionLayoutItem(layoutSize: featuredItemSize)
            
            let normalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(150))
            let normalItem = NSCollectionLayoutItem(layoutSize: normalItemSize)
            
            let pairGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
            let pairGroup = NSCollectionLayoutGroup.horizontal(layoutSize: pairGroupSize, subitems: [normalItem, normalItem])
            pairGroup.interItemSpacing = .fixed(10)
            
            let section: NSCollectionLayoutSection
            if sectionIndex == 0 {
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [featuredItem])
                section = NSCollectionLayoutSection(group: group)
            } else {
                section = NSCollectionLayoutSection(group: pairGroup)
            }
            
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            return section
        }
        
        return layout
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedProductCell.identifier, for: indexPath) as? FeaturedProductCell else {
                return UICollectionViewCell()
            }
            if let product = viewModel?.products.first {
                cell.configure(product: product)
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
                return UICollectionViewCell()
            }
            if let product = viewModel?.products[indexPath.item + 1] {
                cell.configure(product: product)
            }
            return cell
        }
    }
}
