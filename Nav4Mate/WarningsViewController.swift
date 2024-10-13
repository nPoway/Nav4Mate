import UIKit

class WarningsViewController: UIViewController {
    var networkManager: NetworkManager
    let parser = Parser()
    var warnings: [Warning] = []
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    init(navArea: NavArea) {
        self.networkManager = NetworkManager(navArea: navArea)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupActivityIndicator()
        fetchData()
        view.backgroundColor = .systemGray6
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.register(WarningsTableViewCell.self, forCellReuseIdentifier: "warningCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemGray
        tableView.layer.cornerRadius = 12
        tableView.clipsToBounds = true
        tableView.isHidden = true
    }
    
    private func fetchData() {
        activityIndicator.startAnimating()
        networkManager.fetchData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let html):
                self.warnings = self.parser.parseHTML(html)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    if self.warnings.isEmpty {
                        self.showAlert(with: "Error", message: "No warnings found for this area. Try again later.")
                    }
                    self.activityIndicator.stopAnimating()
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
                
            case .failure(_):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.activityIndicator.stopAnimating()
                    self.showAlert(with: "Error", message: "Something happened while fetching data. Try again later.")
                }
            }
        }
    }
    private func showAlert(with title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension WarningsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return warnings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "warningCell", for: indexPath) as! WarningsTableViewCell
        let warning = warnings[indexPath.row]
        
        cell.configure(with: warning)
        return cell
    }
}
