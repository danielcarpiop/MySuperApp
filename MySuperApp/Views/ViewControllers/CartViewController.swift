import UIKit
import Combine

class CartViewController: UIViewController {
    private let tableView = UITableView()
    private let totalAmountView = UIView()
    private let totalAmountLabel = UILabel()
    private let purchaseButton = UIButton(type: .system)
    
    private let customNavigationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cart"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        setupTitleCart()
        setupTableView()
        setupTotalAmountView()
        bindViewModel()
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchCartItems()
        setupTotalAmountView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        totalAmountView.removeFromSuperview()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        totalAmountView.removeFromSuperview()
    }
    
    private func setupTitleCart() {
        view.addSubview(customNavigationBar)
        customNavigationBar.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerYAnchor.constraint(equalTo: customNavigationBar.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: customNavigationBar.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: setupBackButton())
    }
    
    private func setupBackButton() -> UIButton {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.setTitle(" Home", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
        
        return button
    }
    
    @objc private func goHome() {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 0
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartItemCell.self, forCellReuseIdentifier: CartItemCell.identifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.clipsToBounds = true
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75)
        ])
    }
    
    private func setupTotalAmountView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        window.addSubview(totalAmountView)
        setupTotalAmountViewLayout(window: window)
    }
    
    private func setupTotalAmountViewLayout(window: UIWindow) {
        totalAmountView.backgroundColor = .white
        totalAmountView.layer.cornerRadius = 20
        totalAmountView.layer.shadowColor = UIColor.black.cgColor
        totalAmountView.layer.shadowOpacity = 0.2
        totalAmountView.layer.shadowOffset = CGSize(width: 0, height: -2)
        totalAmountView.layer.shadowRadius = 5
        totalAmountView.translatesAutoresizingMaskIntoConstraints = false
        
        totalAmountLabel.font = UIFont.boldSystemFont(ofSize: 24)
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.backgroundColor = .systemBlue
        purchaseButton.setTitleColor(.white, for: .normal)
        purchaseButton.layer.cornerRadius = 10
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        
        totalAmountView.addSubview(totalAmountLabel)
        totalAmountView.addSubview(purchaseButton)
        
        NSLayoutConstraint.activate([
            totalAmountView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            totalAmountView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            totalAmountView.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: 30),
            totalAmountView.heightAnchor.constraint(equalToConstant: 150),
            
            totalAmountLabel.centerXAnchor.constraint(equalTo: totalAmountView.centerXAnchor),
            totalAmountLabel.topAnchor.constraint(equalTo: totalAmountView.topAnchor, constant: 16),
            
            purchaseButton.trailingAnchor.constraint(equalTo: totalAmountView.trailingAnchor, constant: -50),
            purchaseButton.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: 16),
            purchaseButton.leadingAnchor.constraint(equalTo: totalAmountView.leadingAnchor, constant: 50),
            purchaseButton.heightAnchor.constraint(equalToConstant: 50),
            purchaseButton.bottomAnchor.constraint(equalTo: totalAmountView.bottomAnchor, constant: -40),
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
                self?.totalAmountLabel.text = "Total amount:  $\(totalAmount) USD"
            }
            .store(in: &cancellables)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel, let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.identifier, for: indexPath) as? CartItemCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.configure(with: product)
        
        cell.removeProduct = { [weak self] in
            self?.viewModel?.removeProduct(at: indexPath.row)
        }
        
        cell.incrementProduct = { [weak self] in
            self?.viewModel?.addProduct(product: product)
        }
        
        cell.decrementProduct = { [weak self] in
            self?.viewModel?.addProduct(product: product, isIncrement: false)
        }
        
        return cell
    }
}
