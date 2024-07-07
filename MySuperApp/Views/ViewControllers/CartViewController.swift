import UIKit
import Combine

class CartViewController: UIViewController {
    private let tableView = UITableView()
    private let totalAmountView = UIView()
    private let totalAmountLabel = UILabel()
    private let purchaseButton = UIButton(type: .system)
    
    private var viewModel: CartViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupTotalAmountView()
        bindViewModel()
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Cart"
        let backButton = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(goHome))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func goHome() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartItemCell.self, forCellReuseIdentifier: CartItemCell.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150)
        ])
    }
    
    private func setupTotalAmountView() {
        view.addSubview(totalAmountView)
        totalAmountView.backgroundColor = .white
        totalAmountView.layer.cornerRadius = 20
        totalAmountView.layer.shadowColor = UIColor.black.cgColor
        totalAmountView.layer.shadowOpacity = 0.2
        totalAmountView.layer.shadowOffset = CGSize(width: 0, height: -2)
        totalAmountView.layer.shadowRadius = 5
        totalAmountView.translatesAutoresizingMaskIntoConstraints = false
        
        totalAmountLabel.font = UIFont.boldSystemFont(ofSize: 18)
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.backgroundColor = .systemBlue
        purchaseButton.setTitleColor(.white, for: .normal)
        purchaseButton.layer.cornerRadius = 10
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        
        totalAmountView.addSubview(totalAmountLabel)
        totalAmountView.addSubview(purchaseButton)
        
        NSLayoutConstraint.activate([
            totalAmountView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalAmountView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalAmountView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            totalAmountLabel.centerXAnchor.constraint(equalTo: totalAmountView.centerXAnchor),
            totalAmountLabel.topAnchor.constraint(equalTo: totalAmountView.topAnchor, constant: 16),
            
            purchaseButton.trailingAnchor.constraint(equalTo: totalAmountView.trailingAnchor, constant: -50),
            purchaseButton.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: 16),
            purchaseButton.leadingAnchor.constraint(equalTo: totalAmountView.leadingAnchor, constant: 50),
            purchaseButton.heightAnchor.constraint(equalToConstant: 50),
            purchaseButton.bottomAnchor.constraint(equalTo: totalAmountView.bottomAnchor, constant: -16),
        ])
    }
    
    private func bindViewModel() {
        viewModel?.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
        
        viewModel?.$totalAmount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] totalAmount in
                self?.totalAmountLabel.text = "Total amount: $\(totalAmount) CLP"
            }
            .store(in: &cancellables)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel, let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.identifier, for: indexPath) as? CartItemCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.configure(with: product)
        
        cell.removeSubject
            .sink { [weak self] in
                guard let self = self else { return }
                self.viewModel?.removeProduct(at: indexPath.row)
            }
            .store(in: &cancellables)
        
        cell.incrementSubject
            .sink { [weak self] in
                guard let self = self else { return }
                self.viewModel?.incrementQuantity(of: product)
            }
            .store(in: &cancellables)
        
        cell.decrementSubject
            .sink { [weak self] in
                guard let self = self else { return }
                self.viewModel?.decrementQuantity(of: product)
            }
            .store(in: &cancellables)
        
        return cell
    }
}
