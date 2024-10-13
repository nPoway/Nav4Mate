import UIKit

class NavAreaSelectionViewController: UIViewController {
    
    let navAreas = NavArea.allAreas()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 12
        tableView.clipsToBounds = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        view.backgroundColor = .systemBackground
    }
    
    private func setupUI() {
        navigationItem.title = "Select Navarea"
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupTableView() {
        tableView.register(NavAreaTableViewCell.self, forCellReuseIdentifier: "navAreaCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemGray
    }
}

extension NavAreaSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navAreas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "navAreaCell", for: indexPath) as! NavAreaTableViewCell
        let areaName = navAreas[indexPath.row]
        cell.configure(with: areaName)
    
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNavArea = NavArea.allCases[indexPath.row]
        let warningVC = WarningsViewController(navArea: selectedNavArea)
        warningVC.title = selectedNavArea.rawValue
        navigationController?.pushViewController(warningVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: 20)
        UIView.animate(withDuration: 0.3) {
            cell.transform = CGAffineTransform.identity
        }
    }
}
